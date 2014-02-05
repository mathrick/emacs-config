;; This file will bootstrap a fresh VCS checkout on a vanilla Emacs
;; install and bring it up to the state where the Grail & Pallet
;; dependency management can kick in.

;; See README on how to use

(defun bootstrap-melpa ()
  (let* ((my-path (or load-file-name
		      (buffer-file-name)))
         (my-dir (file-name-directory my-path)))
    (unless (require 'package nil t)
      (grail-install-elpa))
    (save-excursion
      (switch-to-buffer (loop for file in '("package-filter.el"
                                            "package-filter.el.txt")
                              for path = (expand-file-name file my-dir)
                              if (file-exists-p path)
                              return (find-file path)
                              finally return
                              (url-retrieve-synchronously
                               "https://raw.github.com/milkypostman/package-filter/master/package-filter.el")))
      (package-install-from-buffer (package-buffer-info) 'single)
      (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
      (when (< emacs-major-version 24)
	(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))))))

(defun bootstrap-pallet ()
  (package-refresh-contents)
  (package-install 'pallet))

(defun bootstrap-packages ()
  ;; Need to force it
  (require 'cask)
  (load-library "pallet-overrides")
  (pt/cask-up)
  (cask-install))

(defun bootstrap-finish ()
  (display-about-screen)
  (delete-other-windows)
  (message "Bootstrap complete!"))

(bootstrap-melpa)
(bootstrap-pallet)
(bootstrap-packages)
(bootstrap-finish)
