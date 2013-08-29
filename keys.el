;;; Keybindings to be loaded by grail.el

;; Windmove
(windmove-default-keybindings 'meta)

;; List and sexp navigation
(global-set-key "C-M-<right>" 'forward-list)
(global-set-key "C-M-<left>"  'backward-list)
(global-set-key "M-n"         'up-list)
(global-set-key "C-s-<right>" 'forward-sexp)
(global-set-key "C-s-<left>"  'backward-sexp)

;; Misc
(global-set-key (kbd "C-c k")   'browse-kill-ring)
(global-set-key (kbd "C-c C-v") 'uncomment-region)
(global-set-key (kbd "C-h d")   'describe-function)
(global-set-key (kbd "C-h a")   'apropos)

;; Text manip and navigation
(global-set-key (kbd "C-f") 'goto-char-forward)
(global-set-key (kbd "C-b") 'goto-char-backward)

(global-set-key [(control c) (control t)] (lambda (text)  (wrap-region-with-text text)))

(global-set-key (kbd "C-x RB") 're-builder)
(global-set-key (kbd "C-x RS") 're-search-forward)
(global-set-key (kbd "C-x Rb") 're-search-backward)
(global-set-key (kbd "C-x RA") 're-search-forward-or-backward)
(global-set-key (kbd "C-x RR") 'replace-regexp)
(global-set-key (kbd "C-x RQ") 'query-replace-regexp)

;; Multiple cursors
(require 'mc-cycle-cursors)

(global-set-key (kbd "C-c C->") 'mc/edit-lines)
(global-set-key (kbd "M-RET") 'set-rectangular-region-anchor)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "M->") 'mc/mark-all-like-this-dwim)

(global-set-key (kbd "C-?") 'er/expand-region)
(global-set-key (kbd "M-?") 'er/contract-region)

;; Dired
(local-hook-key 'dired-mode-hook "r" 'wdired-change-to-wdired-mode)

;; GDB
(local-hook-key 'gud-mode-hook (kbd "C-c C--") 'gud-attach-dwim)

;; C
(local-hook-key 'c-mode-common-hook (kbd "RET")       'newline-and-indent)
(local-hook-key 'c-mode-common-hook (kbd "C-RET")     'c-indent-new-comment-line)
(local-hook-key 'c-mode-common-hook (kbd "C-j")       'newline)
(local-hook-key 'c-mode-common-hook (kbd "C-<right>") 'c-forward-into-nomenclature)
(local-hook-key 'c-mode-common-hook (kbd "C-<left>")  'c-backward-into-nomenclature)

(put 'c-backward-into-nomenclature 'CUA 'move)
(put 'c-forward-into-nomenclature 'CUA 'move)

(put 'camelCase-forward-word 'CUA 'move)
(put 'camelCase-backward-word 'CUA 'move)

;; Python
(local-hook-key 'python-mode-hook (kbd "RET") 'newline-and-indent)

;; Paredit
;; Customise keys
(eval-after-load "paredit"
  '(let ((map paredit-mode-map))
     (mapcar (lambda (key)
               (define-key map (read-kbd-macro key) nil))
             (list
              "C-M-p"
              "C-M-n"
              "M-<up>"
              "M-<down>"
              "C-<right>"
              "C-<left>"
              "C-M-<left>"
              "C-M-<right>"))
     (define-key map (kbd ")") 'paredit-close-round-and-newline)
     (define-key map (kbd "M-)") 'paredit-close-round)
     (define-key map (kbd "<delete>") 'paredit-forward-maybe-delete-region)
     (define-key map (kbd "DEL") 'paredit-backward-maybe-delete-region)))

;; Lisp
(local-hook-key 'emacs-lisp-mode-hook (kbd "C-c C-c") 'eval-defun)

(local-hook-key 'lisp-mode-hook (kbd "RET")       'newline-and-indent)
(local-hook-key 'lisp-mode-hook (kbd "TAB")       'slime-indent-and-complete-symbol)
(local-hook-key 'lisp-mode-hook (kbd "C-c S-RET") 'slime-macroexpand-1-inplace)
(local-hook-key 'lisp-mode-hook (kbd "C-c M-M")   'slime-macroexpand-all-inplace)

;; Mode-specific info lookup (for ANSI CL in Info format)
(global-set-key (kbd "C-h C-i") 'info-lookup-symbol)
