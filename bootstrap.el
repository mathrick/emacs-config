;; This file will bootstrap a fresh VCS checkout on a vanilla Emacs
;; install and bring it up to the state where the Grail & Pallet
;; dependency management can kick in.

;; To use

;; 0. Open Emacs. Most config won't work, but that's OK, as grail
;;    suppresses errors
;; 1. Switch to *scratch*
;; 2. (grail-install-elpa)
;; 3. C-j
;; 2. (load-file "~/elisp/bootstrap.el")
;; 3. C-j

;; 4. When it's done, there should be a working config. Restart Emacs,
;;    check if no errors are reported in *scratch* (that's where grail
;;    stuffs them)

(defun bootstrap-elisp ()
  (save-excursion
    (switch-to-buffer (url-retrieve-synchronously
		       "https://raw.github.com/milkypostman/melpa/master/melpa.el"))
    (package-install-from-buffer (package-buffer-info) 'single)
    (package-install "pallet"))

(bootstrap-elisp)
