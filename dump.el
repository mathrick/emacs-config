
(require 'org-install)
(require 'org-special-blocks)

;; do not bug me about saving my abbreviations
(setq save-abbrevs nil)

;; (require 'msf-abbrev)
;; (global-msf-abbrev-mode t) ;; for all modes with abbrevs or
;; ;; M-x msf-abbrev-mode RET ;; for only one buffer

;; ;; You may also want to make some bindings:
;; (global-set-key (kbd "C-c l") 'msf-cmd-goto-root)
;; (global-set-key (kbd "C-c A") 'msf-cmd-define)
;; (global-set-key [(control tab)] 'msf-cmd-make-choice)

(server-mode t)

(load-file "~/elisp/highlight-parentheses.el")
(require 'highlight-parentheses)

(defun check-region-parens ()
  "Check if parentheses in the region are balanced. Signals a
scan-error if not."
  (interactive)
  (save-restriction
    (save-excursion
    (let ((deactivate-mark nil))
      (condition-case c
          (progn 
            (narrow-to-region (region-beginning) (region-end))
            (goto-char (point-min))
            (while (/= 0 (- (point)
                            (forward-list))))
            t)
        (scan-error (signal 'scan-error '("Region parentheses not balanced"))))))))

(defun paredit-backward-maybe-delete-region ()
  (interactive)
  (if mark-active
      (progn
        (check-region-parens)
        (cua-delete-region))
    (paredit-backward-delete)))

(defun paredit-forward-maybe-delete-region ()
  (interactive)
  (if mark-active
      (progn
        (check-region-parens)
        (cua-delete-region))
    (paredit-forward-delete)))

(load-file "~/elisp/paredit.el")
;; Customise keys
(eval-after-load "~/elisp/paredit.el"
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

(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(add-hook 'lisp-mode-hook 'highlight-parentheses-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)

(add-hook 'emacs-lisp-mode-hook (lambda () (local-set-key (kbd "C-c C-c") 'eval-defun)))

;; (add-to-list 'load-path "~/elisp/slime/")  ; your SLIME directory
;; (add-to-list 'load-path "~/elisp/slime/contrib/")  ; your SLIME directory
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq load-path (remove "/usr/share/emacs-snapshot/site-lisp/slime" load-path))
(require 'slime)
(slime-setup '(slime-fancy slime-indentation slime-asdf 
               slime-mrepl slime-media ;; slime-mdot-fu
               ))

(defun define-cl-indent (el)
  (put (car el) 'common-lisp-indent-function 
       (if (symbolp (cdr el))
           (get (cdr el) 'common-lisp-indent-function)
         (cadr el))))

(define-cl-indent '(&rest (&whole 2 &rest 2)))
(define-cl-indent '(if   (4 4 2)))
(define-cl-indent '(restart-bind . handler-bind))

;; Parenscript/Raphaël JS
(define-cl-indent '(defaccesor 999))
(define-cl-indent '(defpsmethod 999))
(define-cl-indent '(defattr . tagbody))

(load-file "~/elisp/redshank/redshank.el")

(add-hook 'lisp-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent)))
(add-hook 'lisp-mode-hook (lambda () (local-set-key (kbd "TAB") 'slime-indent-and-complete-symbol)))
(add-hook 'lisp-mode-hook (lambda () (local-set-key (kbd "C-c S-<return>") 'slime-macroexpand-1-inplace)))
(add-hook 'lisp-mode-hook (lambda () (local-set-key (kbd "C-c M-M") 'slime-macroexpand-all-inplace)))
(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'lisp-mode-hook 'slime-mode)
(add-hook 'slime-mode-hook 'turn-on-redshank-mode)
(add-hook 'slime-repl-mode-hook (lambda () (local-unset-key [(return)])))
(add-hook 'slime-xref-mode-hook (lambda () (local-unset-key [(return)])))

;; (load-file "~/elisp/dvc/dvc-load.el")

(require 'info-look)
(info-lookup-add-help
    :mode 'lisp-mode
    :regexp "[^][()'\" \t\n]+"
    :ignore-case t
    :doc-spec '(("(ansicl)Symbol Index" nil nil nil)))
(global-set-key [(control h) (control i)] 'info-lookup-symbol)

(setq org-agenda-files (list "~/org/work.org"
                             "~/org/school.org"
                             "~/org/projects.org"
                             "~/org/clonebofoo.org"
                             "~/org/misc.org"
                             "~/Dev/Lisp/faktoid/TODO"
                             "~/Dev/Lisp/faktoid/BUGS"))

;; (load "~/elisp/pabbrev.el")
;; (global-pabbrev-mode)

(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/elisp/emacs-rails")
;; (require 'snippet)
;; (require 'rails)

(load-file "~/elisp/nsis-mode.el")
(setq auto-mode-alist (append '(("\\.\\([Nn][Ss][Ii]\\)$" .
                                 nsis-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.\\([Nn][Ss][Hh]\\)$" .
                                 nsis-mode)) auto-mode-alist))

;; YASnippet
(add-to-list 'load-path
             "~/elisp/dist/yasnippet-0.6.1c/")
(require 'yasnippet) ;; not yasnippet-bundle
(setq yas/root-directory '("~/elisp/local/snippets" "~/elisp/dist/yasnippet-0.6.1c/snippets"))
(yas/initialize)
(yas/reload-all)

;;; Guess basic indent offsets
(add-to-list 'load-path "~/elisp/dist/dtrt-indent/")
(require 'dtrt-indent)
(dtrt-indent-mode 1)

;; (load "~/elisp/dist/nxhtml/autostart.el")

(set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8)
(pushnew '(utf-8 t "utf-8") slime-net-valid-coding-systems :key #'car)
(setq slime-lisp-implementations
      '(;; (sbcl-kabinett ("sbcl" "--core" "/home/mathrick/Dev/Lisp/kabinett/sbcl.core")
        ;;                :init-function (lambda ()
        ;;                                 (slime-repl-eval-string " (progn
        ;;                                                             (asdf:oos 'asdf:load-op :kabinett-test)
        ;;                                                             (in-package :kabinett-test))")))
        ;; (sbcl-kabinett-clean ("sbcl" "--core" "/home/mathrick/Dev/Lisp/kabinett/sbcl.core"))
        (sbcl-clean ("sbcl"))
        ;; (sbcl-goo ("sbcl" "--core" "/home/mathrick/Dev/Lisp/goo-canvas/sbcl.core"))
        ;; (sbcl-gtk ("sbcl" "--core" "/home/mathrick/Dev/BMB/tools/gtk.core"))
        (ccl ("/home/mathrick/Dev/ccl/lx86cl64"))
        (ecl ("ecl") :coding-system iso-latin-1-unix)))
(setq slime-default-lisp 'sbcl-clean)

(defun rm-jlpt-field ()
  (interactive)
  (save-excursion
    (let ((eol (point-at-eol))
          (point (point)))
      (forward-char)
      (when (search-forward-regexp "[[:space:]]" eol 'bound)
        (goto-char (match-beginning 0)))
      (when (search-forward-regexp "[^[:space:]]" eol 'bound)
        (goto-char (match-beginning 0)))
      (delete-region point (point)))))

(defun forward-jlpt-field ()
  (interactive)
  (condition-case var
    (let ((eol (point-at-eol))
          (point (point)))
      (forward-char)
      (search-forward-regexp "[[:space:]]" eol)
      (search-forward-regexp "[^[:space:]]" eol)
      (backward-char))
    ('search-failed (next-line))))

(defun backward-jlpt-field ()
  (interactive)
  (condition-case var
    (let ((bol (point-at-bol))
          (point (point)))
      (backward-char)
      (search-backward-regexp "[^[:space:]]" bol)
      (search-backward-regexp "[[:space:]]" bol)
      (forward-char)
      (unless (>= (current-column) goal-column)
        (signal 'search-failed "Search failed")))
    ('search-failed 
     (previous-line)
     (end-of-line)
     (search-backward-regexp "[[:space:]]" (point-at-bol))
     (forward-char))))

(defun jlpt-kanji-mode ()
  (interactive)
  (setf goal-column 16)
  (local-set-key [left] 'backward-jlpt-field)
  (local-set-key [right] 'forward-jlpt-field)
  (local-set-key [SPC] 'rm-jlpt-field))

(put 'downcase-region 'disabled nil)

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

(load-file "~/elisp/php-mode.el")
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

;; Compatibility hack for JDEE
(defalias 'turn-on-font-lock-if-enabled 'turn-on-font-lock-if-desired)

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
