;; This file will bootstrap a fresh VCS checkout on a vanilla Emacs
;; install and bring it up to the state where the Grail & Pallet
;; dependency management can kick in.

;; See README on how to use

(defun bootstrap-melpa ()
  (grail-install-elpa)
  (save-excursion
    (switch-to-buffer (url-retrieve-synchronously
		       "https://raw.github.com/milkypostman/melpa/master/melpa.el"))
    (package-install-from-buffer (package-buffer-info) 'single)
    (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
    (when (< emacs-major-version 24)
      (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))))

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
