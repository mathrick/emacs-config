;;; Keybindings to be loaded by grail.el

;; Windmove
(windmove-default-keybindings 'meta)

;; List and sexp navigation
(global-set-key [(meta control right)] 'forward-list)
(global-set-key [(meta control left)] 'backward-list)
(global-set-key [(meta n)] 'up-list)
(global-set-key [(control super right)] 'forward-sexp)
(global-set-key [(control super left)] 'backward-sexp)

;; Misc
(global-set-key (kbd "C-c k") 'browse-kill-ring)
(global-set-key (kbd "C-c C-v") 'uncomment-region)
(global-set-key (kbd "C-h d") 'describe-function)
(global-set-key (kbd "C-h a") 'apropos)

;; Text manip and navigation
(global-set-key [(meta control n)] 'goto-char-forward)
(global-set-key [(meta control p)] 'goto-char-backward)

(global-set-key [(control c) (control t)] (lambda (text)  (wrap-region-with-text text)))

(global-set-key (kbd "C-x RB") 're-builder)
(global-set-key (kbd "C-x RS") 're-search-forward)
(global-set-key (kbd "C-x Rb") 're-search-backward)
(global-set-key (kbd "C-x RA") 're-search-forward-or-backward)
(global-set-key (kbd "C-x RR") 'replace-regexp)
(global-set-key (kbd "C-x RQ") 'query-replace-regexp)

;; Dired
(local-hook-key 'dired-mode-hook "r" 'wdired-change-to-wdired-mode)

;; GDB
(local-hook-key 'gud-mode-hook [(control -)] 'gud-attach-dwim)

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
(loca-hook-key 'python-mode-hook (kbd "RET") 'newline-and-indent)

