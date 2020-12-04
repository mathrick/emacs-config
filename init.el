;; Mostly borrowed from Chemacs
(defun handle-mood-root-command-line-args (args)
  (when args
    (let* ((arg (car args))
	   (rest (cdr args))
	   ;; Handle both "--with-mood foo" and "--with-mood=foo"
	   (s (split-string arg "=")))
      (cond
       ((string= arg "--with-mood")
	;; This is just a no-op so Emacs knows --with-profile is a
	;; valid option. If we wait for command-switch-alist to be
	;; processed then after-init-hook has already run.
	(add-to-list 'command-switch-alist
		     '("--with-mood" .
		       (lambda (_) (pop command-line-args-left))))
	(car rest))
       ((string= (car s) "--with-mood")
	(add-to-list 'command-switch-alist (cons arg #'identity))
	(mapconcat #'identity (cdr s) "="))
       (t (handle-mood-root-command-line-args rest))))))

(let ((mood-file (abbreviate-file-name
		  (expand-file-name "mood.el" user-emacs-directory)))
      (mood-root (handle-mood-root-command-line-args command-line-args))
      (use-dialog-box nil))
  (cond
   ((not (file-exists-p mood-file))
    (let ((mood-root (or mood-root
			 (read-directory-name (format "%s not found. Where is Mood checkout root? "
						      mood-file)
					      nil nil t))))
      (with-temp-file mood-file
	(prin1 `(load ,(abbreviate-file-name (expand-file-name "mood" mood-root)))
	       (current-buffer)))
      (load (expand-file-name "mood.el" mood-root))))
   (mood-root
    (load (expand-file-name "mood.el" mood-root)))
   (t (load mood-file))))
