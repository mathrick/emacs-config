;; First of all, init package.el and MELPA
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(mouse-wheel-mode t)
(column-number-mode t)
;; no bell please
(setq ring-bell-function (lambda ()))

;; don't truncate in vertically split windows
(setq truncate-partial-width-windows nil)
