;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;; This file is a dump of everything from my old user.el that I  ;;; 
;;; haven't properly migrated to the new and shiny, real Grail    ;;; 
;;; structure yet. It's not loaded, and will eventually disappear ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

(defvar lisp-symbol-segment
  "\\([^-]*\\)\\(-\\|$\\)"
  "Regexp to match a single segment in a lisp symbol name (ie. \"foo-\" in \"foo-bar-baz\").")

(defun lisp-explode-symbol (sym)
         "Convert a symbol of the form FOO-BAR-BAZ into a list of (\"foo\" \"bar\" \"baz\")."
         (let ((name (if (symbolp sym) 
                         (symbol-name sym)
                       sym))
               (strings ())
               (match 0)
               start)
           (while (< match (length name))
             (setf match (string-match lisp-symbol-segment name start))
             (when (and match
                        (< match (length name)))
               (push (match-string 1 name) strings)
               (setf start (match-end 0))))
           (reverse strings)))

(defun lisp-cpc-completion-symbols (pattern &optional obarr predicate dont-explode min-len)
  (unless predicate
    (setf predicate 'symbolp))
  (let ((symbols ())
        (pattern (format "^%s.*$"
                         (replace-regexp-in-string lisp-symbol-segment "\\1[^-]*\\2"
                                        ; Escape regex special chars
                                                   (replace-regexp-in-string "\\(\\*\\|\\[\\|\\.\\)" "\\\\\\1" pattern)))))
    (mapatoms (lambda (sym)
                (when (and (string-match pattern (symbol-name sym))
                           (funcall predicate sym)
                           (>= (length (lisp-explode-symbol sym)) (or min-len 0)))
                  (push (if dont-explode
                            (symbol-name sym)
                          (lisp-explode-symbol sym))
                        symbols)))
              (or obarr obarray)) ;; Elisp is dumb
    symbols))

(defun lisp-cpc-zip-completions (completions &optional min-length)
  "Convert a list of exploded symbol names into a single string of composed of longest common prefixes separated by \"-\"."
  (when completions
    (let* ((max-index (1- (loop for c in completions
                                minimizing (length c))))
           ;; Switch rows with columns
           (completions (loop for i from 0 to max-index
                              collecting
                              (loop for c in completions
                                    collecting (elt c i)))))
      (flet ((char-at (string index)
                      (when (< index (length string))
                        (elt string index))))
        (let* ((strings (loop for items in completions
                              collecting
                              (let ((prefix "")
                                    (idx 0))
                                (while (and (char-at (car items) idx)
                                            (every (lambda (item)
                                                     (when (char-at item idx)
                                                      (eql (downcase (char-at item idx)) 
                                                           (downcase (char-at (car items) idx)))))
                                                   items))
                                  (setq prefix (concat prefix (list (char-at (car items) idx))))
                                  (incf idx))
                                prefix)))
               (cand (car strings)))
          (loop for (string . tail) on (cdr strings)
                do (unless (and (> (length strings) (1+ max-index))
                                (not tail)
                                (equal string ""))
                     (setf cand (concat cand "-" string))))
          cand)))))

(defun lisp-cpc-try-completion (pattern collection &optional predicate)
  (let* ((completions (lisp-cpc-completion-symbols pattern collection predicate nil 
                                              (length (lisp-explode-symbol pattern))))
         (cand (lisp-cpc-zip-completions completions)))
    (if (and (= (length completions) 1)
             (equal cand pattern))
        t
      cand)))

(defun lisp-cpc-all-completions (pattern collection &optional predicate ignore)
  (lisp-cpc-completion-symbols pattern collection predicate t))

(defadvice lisp-complete-symbol (around lisp-cpc-complete-advice)
  (let ((old-try-completion (symbol-function 'try-completion))
        (old-all-completions (symbol-function 'all-completions)))
      (unwind-protect
          (progn
            (while (looking-at-p "\\s_\\|\\w")
              (forward-char))
            (setf (symbol-function 'try-completion) (symbol-function 'lisp-cpc-try-completion))
            (setf (symbol-function 'all-completions) (symbol-function 'lisp-cpc-all-completions))
            ad-do-it)
        (setf (symbol-function 'try-completion) old-try-completion)
        (setf (symbol-function 'all-completions) old-all-completions))))

(ad-activate 'lisp-complete-symbol)

;;; Vim

;; (setq viper-mode t)                ; enable Viper at load time
;; (setq viper-ex-style-editing nil)  ; can backspace past start of insert / line
;; (setq viper-want-ctl-h-help t)     ; C-h is help, not vi motion
;; (require 'redo)
;; (require 'rect-mark)
;; (require 'viper)                   ; load Viper
;; (require 'vimpulse)                ; load Vimpulse
;; ;; Make sure that C-[ is the same as ESC
;; (global-set-key "\C-z" 'toggle-viper-mode)
;; (define-key viper-insert-global-user-map (kbd "\C-[") 'viper-intercept-ESC-key)
(setq woman-use-own-frame nil)     ; don't create new frame for manpages
(setq woman-use-topic-at-point t)  ; don't prompt upon K key (manpage display)

;; Load CUA after viper, otherwise visual mode breaks
(cua-mode t)

;; Spellchecking
(require 'rw-language-and-country-codes)
(require 'rw-ispell)
(require 'rw-hunspell)

(add-hook 'ispell-initialize-spellchecker-hook
      (lambda ()
    (setq ispell-base-dicts-override-alist
          '((nil ; default
         "[A-Za-z]" "[^A-Za-z]" "[']" t
         ("-d" "en_US" "-i" "utf-8") nil utf-8)
        ("american" ; Yankee English
         "[A-Za-z]" "[^A-Za-z]" "[']" t
         ("-d" "en_US" "-i" "utf-8") nil utf-8)
        ("british" ; British English
         "[A-Za-z]" "[^A-Za-z]" "[']" t
         ("-d" "en_GB" "-i" "utf-8") nil utf-8)))))

;; Emacs-chrome
(load-file "~/elisp/dist/emacs_chrome/servers/edit-server.el")
(progn
  (require 'edit-server)
  (edit-server-start)
  (defadvice edit-server-done (around dont-kill-edit-buffer-on-save activate)
    (setf nokill t)
    ad-do-it))

;; DVC
(load-file "/home/mathrick/elisp/dist/dvc/dvc-load.el")
(dvc-show-active-dvc 1)

;; bookmarklets
(fset 'bookmarklet-minify-macro
   [?\C-x ?b ?u ?p ?l ?o ?a ?d ?_ ?b ?o ?o ?k ?m ?a ?r ?k ?l ?e ?t ?. ?j ?s ?\C-m ?\C-x ?h C-insert ?\C-x ?b ?a ?s ?d ?\C-m ?\C-x ?h S-insert C-home ?\C-x ?R ?R ?\C-q ?\C-j ?\C-m ?\C-m C-home ?\C-x ?R ?R ?  ?+ ?\C-m ?  ?\C-m C-home ?\C-x ?R ?R ?  ?? ?\\ ?\( ?\[ ?+ ?= ?\{ ?\} ?\( ?\) ?\; ?, ?. ?% ?/ ?^ ?- ?\] ?\\ ?\) ?  ?? ?\C-m ?\\ ?1 ?\C-m C-home ?\C-x ?R ?R ?  ?\C-m ?% ?2 ?0 ?\C-m C-home ?j ?a ?v ?a ?s ?c ?r ?i ?p ?t ?: ?\C-x ?h C-insert ?\M-: ?\( ?x ?- ?s ?e ?t ?- ?s ?e ?l ?e ?c ?t ?i ?o ?n ?\' ?C ?L ?I ?P ?B ?O ?A ?R ?D ?\( ?c ?u ?r ?r ?e ?n ?t ?- ?k ?i ?l ?l ?  ?0 ?  ?t ?\) ?\) ?\C-m ?\C-x ?b ?u ?p ?l ?o ?a ?d ?_ ?b ?o ?o ?k ?m ?a ?r ?k ?l ?e ?t ?. ?j ?s ?\C-m ?\C-u ?\C-  ?\C-u ?\C- ])

(defun bookmarklet-minify ()
  (interactive)
  (command-execute 'bookmarklet-minify-macro)
  (message "Remember it might have messed up SPCs in string literals"))

(defun toggle-split-view (left right)
  (let ((root (car (window-tree))))
    (if (listp root)
        (progn
          (delete-other-windows)
          (switch-to-buffer left))
      (progn
        (split-window-horizontally)
        (switch-to-buffer left)
        (other-window 1)
        (switch-to-buffer right)
        (other-window 1)))))

(load custom-file)

(eval-after-load 'company '(global-company-mode))

(defvar *company-wanted-modes*
  (list
   'c-mode 'c++-mode 'c-mode 'java-mode
   'php-mode 'python-mode 
   'lisp-mode 'emacs-lisp-mode 'inferior-emacs-lisp-mode
   'lisp-interaction-mode
   'shell-script-mode
   'css-mode 'javascript-mode 'html-mode
   'text-mode))

(defun company-mode-if-possible ()
  (when (and (not (window-minibuffer-p))
             (find major-mode
                   *company-wanted-modes*))
    (company-mode)))

;; (define-globalized-minor-mode global-company-mode
;;   company-mode company-mode-if-possible)


;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(autoload 'gradle-mode "gradle-mode" "Gradle task integration." t)
;; For some reason, these recommendations don't seem to work with Aquamacs
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))
;; This does work with Aquamacs
(add-to-list 'auto-mode-alist (cons "\\.gradle\\'" 'groovy-mode))
(add-to-list 'auto-mode-alist (cons "\\.groovy\\'" 'groovy-mode))
;; This _might_ not work with Aquamacs (not sure what value it offers)
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("gradle" . groovy-mode))
;;; make Groovy mode electric by default.
(add-hook 'groovy-mode-hook
          '(lambda ()
             (require 'groovy-electric)
             (groovy-electric-mode)))

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
