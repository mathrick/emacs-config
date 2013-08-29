;;; -*- lexical-binding: t -*-
;;; Library function definitions to be loaded by grail.el

(defun local-hook-key (hook key command)
  "Instal a hook in HOOK that binds KEY to COMMAND via local-set-key"
  ;; Emacs 23 lacks lexical-binding: t
  (lexical-let ((hook hook)
                (key key)
                (command command))
   (add-hook hook (lambda () (local-set-key key command)))))
