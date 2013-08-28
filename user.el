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
(cask-initialize)

(mouse-wheel-mode t)
(column-number-mode t)
;; no bell please
(setq ring-bell-function (lambda ()))

;; don't truncate in vertically split windows
(setq truncate-partial-width-windows nil)
