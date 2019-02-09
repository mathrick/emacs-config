;;; Interactive commands to be loaded by grail.el

(defalias 'ms 'magit-status)

;; GDB
(defun gud-attach-dwim (prg-name) 
  (interactive "sAttach to running programme: ")
  (princ "attach " (current-buffer))
  (call-process "bash" nil t nil "-c" 
                (concat 
                 "ps ax | grep " 
                 prg-name 
                 "| grep -v grep | sed 's/^[[:blank:]]*//g' | cut --delimiter=' ' -f1"))
  (comint-send-input))

;; CC-mode

;; Correct K&R braces. Hacky, needs more work
(defun c-kill-hanging-braces ()
  (interactive)
  (while
      (search-forward "{" nil t)
    (when
        (save-excursion
          (let
              ((line (line-number-at-pos)))
            (if (search-backward-regexp
                 (rx bol (zero-or-more whitespace) "{") nil t)
                (not (eq line
                         (line-number-at-pos))) t))) (backward-char) (insert "\n") (forward-char))))

(defun indent-region-kill-hanging-braces ()
  (save-excursion
    (save-restriction
      (condition-case nil
          (progn
            (narrow-to-region (region-beginning) (region-end))
            (goto-char (point-min))
            (c-kill-hanging-braces))
        (error nil)))))

;; (defadvice indent-region (before indent-region-advice activate)
;;   (when (or
;;          (eq major-mode 'c-mode)
;;          (eq major-mode 'c++-mode))
;;     (indent-region-kill-hanging-braces)))
;; (defadvice c-indent-line-or-region (before indent-region-advice activate)
;;   (indent-region-kill-hanging-braces))

;; Various text manip
(defun uniq-lines () 
  (interactive)
  (replace-regexp "\\(^.+$\\)\\(\n\\1\\)*" "\\1"))

(defun wrap-region-with-text (text)
  (interactive "MWrap with text:")
  (save-restriction
    (narrow-to-region (region-beginning) (region-end))
    (beginning-of-buffer)
    (insert text)
    (end-of-buffer)
    (insert text)))

(defun goto-char-forward (char) 
  (interactive "cGo forward to char: ")
  (while (not (equal (char-after) char))
    (forward-char)))

(defun goto-char-backward (char) 
  (interactive "cGo backward to char: ")
  (while (not (equal (char-after) char))
    (backward-char)))

(defun re-search-forward-or-backward (arg)
  (interactive "MSearch regexp (forward or backward): ")
  (let ((pos (or (search-forward-regexp arg nil t)
                 (search-backward-regexp arg nil t))))
    (when pos
      (goto-char pos))))

;; Parens and paredit
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

;; Compatibility hack for JDEE
(defalias 'turn-on-font-lock-if-enabled 'turn-on-font-lock-if-desired)

;; bookmarklets
(fset 'bookmarklet-minify-macro
   [?\C-x ?b ?u ?p ?l ?o ?a ?d ?_ ?b ?o ?o ?k ?m ?a ?r ?k ?l ?e ?t ?. ?j ?s ?\C-m ?\C-x ?h C-insert ?\C-x ?b ?a ?s ?d ?\C-m ?\C-x ?h S-insert C-home ?\C-x ?R ?R ?\C-q ?\C-j ?\C-m ?\C-m C-home ?\C-x ?R ?R ?  ?+ ?\C-m ?  ?\C-m C-home ?\C-x ?R ?R ?  ?? ?\\ ?\( ?\[ ?+ ?= ?\{ ?\} ?\( ?\) ?\; ?, ?. ?% ?/ ?^ ?- ?\] ?\\ ?\) ?  ?? ?\C-m ?\\ ?1 ?\C-m C-home ?\C-x ?R ?R ?  ?\C-m ?% ?2 ?0 ?\C-m C-home ?j ?a ?v ?a ?s ?c ?r ?i ?p ?t ?: ?\C-x ?h C-insert ?\M-: ?\( ?x ?- ?s ?e ?t ?- ?s ?e ?l ?e ?c ?t ?i ?o ?n ?\' ?C ?L ?I ?P ?B ?O ?A ?R ?D ?\( ?c ?u ?r ?r ?e ?n ?t ?- ?k ?i ?l ?l ?  ?0 ?  ?t ?\) ?\) ?\C-m ?\C-x ?b ?u ?p ?l ?o ?a ?d ?_ ?b ?o ?o ?k ?m ?a ?r ?k ?l ?e ?t ?. ?j ?s ?\C-m ?\C-u ?\C-  ?\C-u ?\C- ])

(defun bookmarklet-minify ()
  (interactive)
  (command-execute 'bookmarklet-minify-macro)
  (message "Remember it might have messed up SPCs in string literals"))
