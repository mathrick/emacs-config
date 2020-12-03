(let ((mood-file (abbreviate-file-name
		  (expand-file-name "mood.el" user-emacs-directory)))
      (use-dialog-box nil))
  (unless (file-exists-p mood-file)
    (let ((mood-root (read-directory-name (format "%s not found. Where is Mood checkout root? "
						  mood-file)
					  nil nil t)))
      (with-temp-file mood-file
	(prin1 `(load ,(abbreviate-file-name (expand-file-name "mood" mood-root)))
	       (current-buffer)))))
  (load mood-file))
