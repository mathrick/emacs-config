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
