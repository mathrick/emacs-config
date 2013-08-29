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
(load-library "pallet-overrides")

;;; Customisations begin here
(require 'ls-lisp)

;; TODO: migrate to custom
;; do not bug me about saving my abbreviations
(setq save-abbrevs nil)

(server-mode t)
