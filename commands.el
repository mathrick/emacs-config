;;; Interactive commands to be loaded by grail.el

(defun gud-attach-dwim (prg-name) 
  (interactive "sAttach to running programme: ")
  (princ "attach " (current-buffer))
  (call-process "bash" nil t nil "-c" 
                (concat 
                 "ps ax | grep " 
                 prg-name 
                 "| grep -v grep | sed 's/^[[:blank:]]*//g' | cut --delimiter=' ' -f1"))
  (comint-send-input))

