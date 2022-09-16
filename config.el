(init! :base                                    ; Base OS, Emacs and Mood config. You probably want all of them
       defaults                                 ; You want them
       os-support                               ; Make working on Windows suck less

       :theme                                   ; A fresh coat of paint
       (doom-themes :theme 'doom-gruvbox)       ; Great artists steal
       ;;zenburn                                ; The original dark theme

       :ui                                      ; General appearance and behaviour
       mood
       ;;defaults                               ; Things we can all agree make sense
       (defaults :font "monofur for Powerline")
       auto-dim                                 ; I want to know where to look
       doom-modeline                            ; Shinier modeline
       ;; (icomplete +vertical)                 ; The unsurprising minibuffer completion
       ;; (selectrum -history)                  ; Flexible minibuffer completion and narrowing
       (vertico -history +posframe)             ; Like selectrum, but even simpler
       (scrolling +yascroll)			; Fancy scrollbars, or minimap, or whatever
       undo                                     ; Less confusing undo system
       ;;(undo +fu +session)                    ; (undo-tree by default, but you can choose undo-fu)
       windswap                                 ; Like windmove, but also moves buffers

       :editing                                 ; It's not an emacsitor!
       defaults                                 ; Basic quality of life improvements
       ;;company                                  ; It's dangerous to type alone
       corfu                                    ; Corfu is to company what vertico is to Ivy
       expand-region                            ; Make 'em bigger
       realgud					; The unified debugger interface, MkII
       smartparens                              ; Nobody likes counting 'em
       multiple-cursors                         ; Trust me, you want this
       visual-regexp                            ; Not for parsing HTML
       visual-fill                              ; I don't want my text as wide as my screen

       copy-file-on-save

       :vcs                                     ; Git, Bazaar, Hg, and others
       (magit +always-show-recent)              ; Honestly, don't even bother with git without it

       :tools                                   ; Various tools and utilities
       vdiff                                    ; What do you mean you don't like ediff?

       :checkers                                ; Trust, but verify
       syntax                                   ; Get squigglies when programming

       :lang                                    ; Languages, of the programming kind
       (elisp +nameless)                        ; This is Emacs, after all
       cl                                       ; Elisp's bigger brother everyone admires
       clojure                                  ; Elisp's cool younger sister
       mood                                     ; Not a real laguage, just helpers for writing Mood modules
       org                                      ; The all-singing, all-dancing organiser
       python                                   ; And the flying circus
       yaml					; The most complicated simple language known to man
       )

;; Auth info storage, used by Magit/Forge for github tokens, amongst
;; other things
(setq auth-sources '("secrets:Login"))

(defalias 'ms 'magit-status)
;; Hack: monofur 10 is 98, monofur 11 is 113, but the old config used
;; 105, which is better than either
(set-face-attribute 'default nil :height 105)

;; Make TAB usable for completion too
(setf tab-always-indent 'complete)

;; Note: can't use emacs-lisp-mode-map because there are 3 different
;; elisp modes and they don't inherit from that
(general-def lisp-mode-shared-map
  "C-c C-c"     #'eval-defun)

(global-subword-mode)

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

;; The built-in GNU style is broken, fix it
(defconst my-c-style
  '("gnu" (c-offsets-alist . ((arglist-close . c-lineup-arglist)
                              (substatement-open   . 0)
                              (case-label          . 4)
                              (statement-case-open . 0)
                              (block-open          . 0)
                              (knr-argdecl-intro   . -)))))
(c-add-style "Corrected GNU" my-c-style nil)
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (csharp-mode . "c#")
                        (other . "Corrected gnu")))

;; Mode-specific info lookup (for ANSI CL in Info format)
(global-set-key (kbd "C-h C-i") 'info-lookup-symbol)

;; TRAMP paths
(use-package tramp
  :straight nil
  :defer t
  :config
  (pushnew 'tramp-own-remote-path tramp-remote-path)

  (connection-local-set-profile-variables 'remote-path-cerebras-dev-vm
					  '((tramp-remote-path . ("~/ws/bin" tramp-default-remote-path))))
  (connection-local-set-profiles
   '(:application tramp :machine "maciej-dev") 'remote-path-cerebras-dev-vm))

;; Common Lisp + Roswell + SLY setup
(defun roswell-impl-dir ()
  (cl-flet ((sh (cmd)
                (replace-regexp-in-string "_" "-" (string-trim (shell-command-to-string cmd)))))
    (let ((dir (downcase (expand-file-name (concat "~/.roswell/impls/"
                                                   (string-join (mapcar #'sh '("uname -m" "uname"))
                                                                "/"))))))
      (when (file-exists-p dir) dir))))

(defun guess-roswell-implementations ()
  "Auto-detect Roswell-installed CL implementations, returning a
  list suitable as a value of `sly-lisp-implementations' or
  `slime-lisp-implementations'"
  (let ((root (roswell-impl-dir)))
    (when root ; Skip if no Roswell impls
      (cl-loop for file in (directory-files root)
               if (and (file-directory-p (expand-file-name file root))
                       (not (string-prefix-p "." file)))
               collect `(,(intern file) ("ros" "-L" ,file "-Q" "run" "--"))))))

(use-package sly
  :config
  (setq sly-lisp-implementations (guess-roswell-implementations))
  ;; Set SBCL-on-Roswell as the default lisp if it's installed
  (destructuring-bind (&optional impl args)
      (assq 'sbcl-bin sly-lisp-implementations)
    (when impl
      (setf sly-default-lisp impl))))

(defun qlot-sly (dir &optional impl)
  "Start SLY through Qlot in given `dir'

If `impl' (a symbol) is given, look it up in `sly-lisp-implementations'
and use its command, otherwise use `sly-default-lisp'"
  (interactive
   (list (read-directory-name "Start SLY+Qlot in directory: " default-directory)
         (if current-prefix-arg
             (intern (completing-read "Lisp implementation to use: " (mapcar #'car sly-lisp-implementations)
                                      nil nil nil nil sly-default-lisp))
           sly-default-lisp)))
  (let* ((ql-dir (or (locate-dominating-file dir "qlfile")
                     (error "No qlfile found in `%s' or its parent directories" dir)))
         (impl (or impl sly-default-lisp))
         (cmdlist (if impl
                      (cadr (assq impl sly-lisp-implementations))
                    (list inferior-lisp-program)))
         ;; Ugly, but when running ros through qlot, it needs an extra "-S ." argument,
         ;; and I can't think of a better way to do this
         (args (destructuring-bind (head tail) (--split-with (not (string= it "ros")) cmdlist)
                 (-concat head (when tail `("ros" "-S" ,ql-dir)) (cdr tail))
                 cmdlist)))
    (sly-start :name (intern (format "%s+qlot" impl))
               :program "qlot" :program-args `("exec" ,@args) :directory ql-dir)))
