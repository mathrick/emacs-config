;;; Keybindings to be loaded by grail.el

;; Windmove
(windmove-default-keybindings 'meta)

;; Remapping of standard keys
(define-key key-translation-map (kbd "s-<tab>") (kbd "M-TAB"))

;; List and sexp navigation
(global-set-key (kbd "C-M-<right>") 'forward-sexp)
(global-set-key (kbd "C-M-<left>")  'backward-sexp)
(global-set-key (kbd "M-n")         'up-list)
(global-set-key (kbd "M-s-<right>") 'forward-list)
(global-set-key (kbd "M-s-<left>")  'backward-list)

;; Misc
(global-set-key (kbd "C-c k")   'browse-kill-ring)
(global-set-key (kbd "C-c C-v") 'uncomment-region)
(global-set-key (kbd "C-h d")   'describe-function)
(global-set-key (kbd "C-h a")   'apropos)

;; Text manip and navigation
(key-chord-define-global "l;" 'iy-go-up-to-char)
(key-chord-define-global ";'" 'iy-go-up-to-char-backward)
(global-set-key (kbd "C-x C-;") 'iy-go-up-to-char-continue)
(global-set-key (kbd "C-x C-,") 'iy-go-up-to-char-continue-backward)
(eval-after-load "iy-go-to-char" '(define-key iy-go-to-char-keymap (kbd "<return>") 'iy-go-to-char-done))

(global-set-key (kbd "C-c C-t") 'wrap-region-with-text)

(global-set-key (kbd "C-x RB") 're-builder)
(global-set-key (kbd "C-x RS") 're-search-forward)
(global-set-key (kbd "C-x Rb") 're-search-backward)
(global-set-key (kbd "C-x RA") 're-search-forward-or-backward)
(global-set-key (kbd "C-x RR") 'replace-regexp)
(global-set-key (kbd "C-x RQ") 'query-replace-regexp)

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

;;; Smartparens
(eval-after-load "smartparens"
  '(progn
     (setq sp-base-key-bindings 'paredit)
     (setq sp-override-key-bindings
           '(
             ("M-<up>"    . nil)
             ("M-<down>"  . nil)
             ("C-<right>" . nil)
             ("C-<left>"  . nil)
             
             ("C-M-<right>" . sp-forward-sexp) ;; navigation
             ("C-M-<left>"  . sp-backward-sexp)
             ("C-M-<up>"    . sp-backward-up-sexp)
             ("C-M-<down>"  . sp-down-sexp)
             ("ESC <up>"    . sp-splice-sexp-killing-backward)
             ("M-S-<up>"    . sp-splice-sexp-killing-backward)
             ("ESC <down>"  . sp-splice-sexp-killing-forward)
             ("M-S-<down>"  . sp-splice-sexp-killing-forward)
             ("M-?"         . sp-convolute-sexp)
             ))
     (sp--update-override-key-bindings)
     (define-key smartparens-mode-map (kbd "M-(") (lambda ()
                                                    (interactive)
                                                    (sp-wrap-with-pair "(")))
     (define-key smartparens-strict-mode-map [remap delete-forward-char] 'sp-delete-char)
     ))

;; Lisp
(local-hook-key 'emacs-lisp-mode-hook (kbd "C-c C-c") 'eval-defun)
(local-hook-key 'emacs-lisp-mode-hook (kbd "RET")     'newline-and-indent)

(local-hook-key 'lisp-mode-hook (kbd "RET")       'newline-and-indent)
(local-hook-key 'lisp-mode-hook (kbd "TAB")       'slime-indent-and-complete-symbol)
(local-hook-key 'lisp-mode-hook (kbd "C-c S-RET") 'slime-macroexpand-1-inplace)
(local-hook-key 'lisp-mode-hook (kbd "C-c M-M")   'slime-macroexpand-all-inplace)

;; Mode-specific info lookup (for ANSI CL in Info format)
(global-set-key (kbd "C-h C-i") 'info-lookup-symbol)

;;; Org Mode
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)

(setq org-cycle-emulate-tab 'whitestart)

(setq org-CUA-compatible t)
(setq org-replace-disputed-keys t)
(setq org-disputed-keys '(([(shift up)] . [(meta p)])
                          ([(shift down)] . [(meta n)])
                          ([(shift left)] . [(meta -)])
                          ([(shift right)] . [(meta +)])
                          ([(meta left)] . [(super left)])
                          ([(meta right)] . [(super right)])
                          ([(meta up)] . [(super up)])
                          ([(meta down)] . [(super down)])
                          ([(control shift right)] . [(meta shift +)])
                          ([(control shift left)] . [(meta shift -)])))


;;; OmniSharp

;;; Electric comma gets it mostly wrong in C#-mode, so disable it
(local-unhook-key 'csharp-mode-hook (kbd ","))

(local-hook-key 'csharp-mode-hook (kbd ".") (lambda ()
                                              (interactive)
                                              (self-insert-command 1)
                                              (company-begin-backend 'company-omnisharp)))
(local-hook-key 'csharp-mode-hook (kbd "C-<tab>") (lambda ()
                                                    (interactive)
                                                    (company-begin-backend 'company-omnisharp)))
(local-hook-key 'csharp-mode-hook (kbd "M-.") 'omnisharp-go-to-definition)
(local-hook-key 'csharp-mode-hook (kbd "M-,") 'pop-tag-mark)
