(init! :base					;; Base OS, Emacs and Mood config. You probably want all of them
       defaults					;; You want them
       os-support				;; Make working on Windows suck less

       :theme					;; A fresh coat of paint
       (doom-themes :theme 'doom-gruvbox)	;; Great artists steal
       ;zenburn					;; The original dark theme

       :ui					;; General appearance and behaviour
       ;defaults				;; Things we can all agree make sense
       (defaults :font "monofur for Powerline")
       auto-dim					;; I want to know where to look
       doom-modeline				;; Shinier modeline
       (icomplete +vertical)			;; The unsurprising minibuffer completion
       ;; (scrolling +yascroll +smooth)		;; Fancy scrollbars, or minimap, or whatever
       undo					;; Less confusing undo system
       ;(undo +fu +session)			;; (undo-tree by default, but you can choose undo-fu)

       ;; :editing					;; It's not an emacsitor!
       ;; defaults					;; Basic quality of life improvements
       ;; company					;; It's dangerous to type alone
       ;; expand-region				;; Make 'em bigger
       ;; smartparens				;; Nobody likes counting 'em
       ;; multiple-cursors				;; Trust me, you want this
       ;; visual-regexp				;; Not for parsing HTML

       ;; :vcs					;; Git, Bazaar, Hg, and others
       ;; magit					;; Honestly, don't even bother with git otherwise

       ;; :lang					;; Languages, of the programming kind
       ;; (elisp +nameless)			;; This is Emacs, after all
       ;; python
       ;; And the flying circus
       )

(defalias 'ms 'magit-status)
;; Hack: monofur 10 is 98, monofur 11 is 113, but the old config used
;; 105, which is better than either
(set-face-attribute 'default nil :height 105)

;; Note: can't use emacs-lisp-mode-map because there are 3 different
;; elisp modes and they don't inherit from that
(general-def lisp-mode-shared-map
  "C-c C-c"     #'eval-defun)

(general-def c-mode-base-map
  "C-<right>"   #'c-forward-into-nomenclature
  "C-<left>"    #'c-backward-into-nomenclature)

(put 'c-backward-into-nomenclature 'CUA 'move)
(put 'c-forward-into-nomenclature 'CUA 'move)

;; Remapping of standard keys
(general-def
  "M-n"         #'up-list
  "M-s-<right>" #'forward-list
  "M-s-<left>"  #'backward-list

  "C-c k"       #'browse-kill-ring
  "C-c C-v"     #'uncomment-region
  "C-h d"       #'helpful-callable
  "C-h a"       #'apropos)

(general-def key-translation-map
  "s-<tab>"     (kbd "M-TAB"))

;; Mode-specific info lookup (for ANSI CL in Info format)
(global-set-key (kbd "C-h C-i") 'info-lookup-symbol)
