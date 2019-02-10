;;; valet.el --- Minimal package manager/tracker   -*- lexical-binding: t; -*-

;; Copyright (C) 2019 Maciej Katafiasz

;; Author: Maciej Katafiasz
;; Keywords: extensions

;;; Commentary:
;; valet.el is a minimal package tracker, designed to work in tandem
;; with grail.el. Loosely based on Pallet/Cask, but without all the
;; project management overhead, and without assuming quite as much
;; about the user's wishes.
;;
;; valet.el's basic task is to record packages you install to a
;; designated file, then install any that aren't present upon Emacs
;; initialisation. This way you only need to commit one small file to
;; represent all the packages your config uses.
;; 

;; 

;;; Code:

(require 'cl-lib)
(require 'package)

(defcustom valet-default-package-file
  (expand-file-name "Valet" user-emacs-directory)
  "Default location of the file where installed packages should be recorded")

(defconst valet-default-package-sources
  '(("gnu" . "http://elpa.gnu.org/packages/")
    ("marmalade" . "http://marmalade-repo.org/packages/")
    ("melpa" . "http://melpa.milkbox.net/packages/")
    ("melpa-stable" . "https://stable.melpa.org/packages/"))
  "List of package.el repositories known by name, whose location
  doesn't need to be provided")

(defun valet-add-source (name location)
  (interactive
   (let* ((name
           (completing-read "Source name: "
                            (valet--known-source-names)
                            nil nil))
          (location
           (read-from-minibuffer "Source location: "
                                 (valet--source-location name t))))
     (list name location)))
  "Add the source NAME to `package-archives'. If LOCATION is
specified, it should be the URL to use. If nil, the default
location taken from `valet-default-package-sources' will be
used."
  (let* ((name (valet--as-name name))
         (location (or location
                       (valet--source-location name))))
    (add-to-list 'package-archives (cons name location))))

(defun valet-ensure-package (name &optional source arg)
  "Ensure the given package NAME is installed. The package will
be installed if missing (using the specified SOURCE if given, or
default one if nil), otherwise no action will be taken.

If called interactively with a prefix ARG, it will prompt for the
source to install from."
  (interactive "sPackage name: \ni\nP")
  (let* ((name (intern (valet--as-name name)))
         (source (if arg
                     (completing-read "Package source to use: "
                                      (valet--known-source-names)
                                      )
                   (when source
                     (valet--as-name source))))
         (location (when source
                     (valet--source-location (valet--as-name source)))))
    (valet--ensure-init)
    (unless (package-installed-p name)
      (let* ((pkg (or
                   (if source
                       (valet--find-package name source)
                     ;; If no source specified, only use the name,
                     ;; don't try to locate a package-desc. Since
                     ;; package-desc refers to a specific source, it
                     ;; might lead to dependency errors that wouldn't
                     ;; happen with the version from another source
                     name)
                   (if source
                       (error "Package `%s' not found in %s archive" name source)
                     (error "Package `%s' not found" name)))))
        (condition-case err
            (progn
             (if source
                 ;; Try to install requirements from the same source too,
                 ;; since package.el is not smart enough not to try to get
                 ;; newer version from another source that depend on a
                 ;; newer Emacs for instance
                 (cl-loop for (req version) in (package-desc-reqs pkg)
                          for req-pkg = (valet--find-package req source version)
                          when req-pkg do (package-install req-pkg)))
             (package-install pkg))
          (error
           (signal (car err)
                   (cons (format "Cannot install %s: %s" name (cadr err))
                         (cdr err)))))))))

(defun valet-ensure (file)
  "Read the given Valet FILE, ensuring all requested packages are
  installed."
  (interactive "fValet file: ")
  (cl-loop for (form . (file line col)) in (valet--read-package-list file)
           do (condition-case err
                  (valet--eval-form form)
                (error
		 (setf valet-error err)
                 (signal (car err)
                         (list (if (cdr err)
                                   (format "Error: %s at %s:%s.%s" (cadr err) file line col)
                                 (format "Error at %s:%s.%s" file line col))))))))

(defun valet-record (file)
  "Record installed packages in FILE. Companion to `valet-ensure'."
  (interactive "FRecord packages to file: ")
  (let* ((forms (mapcar #'car (when (file-exists-p file)
                                (valet--read-package-list file))))
         (package-forms (cl-loop for (head . rest) in forms
                                 when (eq head 'package)
                                 collect
                                 (destructuring-bind (package &key source disabled) rest
                                   (cons head rest))))
         (header-forms (set-difference forms package-forms :test #'equal))
         (recorded (mapcar #'cadr package-forms))
         (installed (mapcar (lambda (x) (valet--as-name (car x))) package-alist))
         (new (set-difference installed recorded :test #'string=)))
    (with-temp-buffer
      (save-excursion
        (insert ";;; -*- mode: emacs-lisp -*-\n")
        (insert ";;; This is a Valet file maintained by valet.el\n")
        (cl-loop for form in (append header-forms '(nil)
                                     (cl-sort
                                      (append package-forms
                                              (cl-loop for pkg in new
                                                       collect `(package ,pkg)))
                                      (lambda (x y)
                                        (string< (valet--as-name x) (valet--as-name y)))
                                      :key #'cadr))
                 do (when form (prin1 form (current-buffer)))
                 do (insert "\n"))
        (write-region (point-min) (point-max) file)))))

(defun valet--ensure-init ()
  (unless package--initialized
    (package-initialize t))
  (unless package-archive-contents
    (package-refresh-contents)))

(defun valet--known-source-names ()
  (cl-remove-duplicates
   (append (mapcar #'car package-archives)
           (mapcar #'car valet-default-package-sources))))

(defun valet--source-location (name &optional no-error)
  (or (cdr (assoc name valet-default-package-sources))
      (unless no-error
        (error "Unknown package source: %s" name))))

(defun valet--as-name (thing)
  (downcase (format "%s" thing)))

(defun valet--find-package (name &optional source version)
  (let ((source (valet--as-name source))
        (version (when version
                   (if (listp version)
                       version
                     (version-to-list (valet--as-name version)))))
        (cand (assq (intern (valet--as-name name)) package-archive-contents)))
    (if (or source version)
        (cl-find nil (cdr cand)
                 :test #'(lambda (_ pkg)
                          (and (or (not source)
                                   (string= (package-desc-archive pkg) source))
                               (or (not version)
                                   (version-list-<= version
                                                    (package-desc-version pkg))))))
      ;; If no source specified, just return the symbol
      (car cand))))

(defun valet--read-package-list (file)
  "Read the Valet file given by FILE"
  (unless (file-exists-p file)
    (error "Cannot find Valet file %s" file))
  (with-temp-buffer
    (save-excursion
      (insert-file-contents file)
      (cl-loop do
               ;; Stolen from Cask, which stole it from bytecomp.el
               (while (progn (skip-chars-forward " \t\n\^l")
                             (looking-at ";"))
                 (forward-line 1))
               until (eobp)
               for pos = (list file (line-number-at-pos) (current-column))
               collect (condition-case err
                           (cons (read (current-buffer)) pos)
                         (error ; Re-signal with position info
                          (error "Error reading Valet file %s:%s,%s: %s"
                                 file (elt pos 1) (elt pos 2) err)))))))

(defun valet--eval-form (form)
  "Define and interpret the Valet file DSL"
  (cl-destructuring-bind (head &rest rest) form
    (cond
     ((eq head 'source)
      (cl-destructuring-bind (name &optional location) rest
        (valet-add-source name location)))
     ((eq head 'package)
      (cl-destructuring-bind (name &key source disabled) rest
        (unless disabled
          (valet-ensure-package name source))))
     (t (error "Uknown Valet directive `%s'" head)))))

(provide 'valet)
;;; valet.el ends here
