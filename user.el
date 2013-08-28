;; Look at README for description of how the packages and dependencies
;; are managed, and how to initialise and fetch packages on a fresh
;; Emacs

;; First of all, init package.el and MELPA
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;; Pallet takes care of summarising installed packages as a Cask manifest
(require 'pallet)
;; We need to coax it to play nice with grail
(defun pt/cask-file ()
  "Location of the Cask file."
  (expand-file-name "Cask" grail-elisp-root))

;; We cannot just call (cask-initialize), since it assumes ~/.emacs.d,
;; and similarly we have to fix up pt/cask-up since it calls that
(defun pt/cask-up (&optional body)
  "Attempt to initialize Cask, optionally running BODY."
  (if (file-exists-p (pt/cask-file))
      (progn
	(setq cask-runtime-dependencies '())
	(cask-setup (file-name-directory (pt/cask-file)))
	(epl-initialize)
	(when body (funcall body)))
    (message "No Cask file found. Run `pallet-init' to create one.")))

(mouse-wheel-mode t)
(column-number-mode t)
;; no bell please
(setq ring-bell-function (lambda ()))

;; don't truncate in vertically split windows
(setq truncate-partial-width-windows nil)
