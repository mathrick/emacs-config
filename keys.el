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

;; Dired
(add-hook 'dired-mode-hook (lambda () (local-set-key "r" 'wdired-change-to-wdired-mode)))

;; GDB
(add-hook 'gud-mode-hook (lambda () (local-set-key [(control -)] 'gud-attach-dwim)))
