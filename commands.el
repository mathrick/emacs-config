;;; Interactive commands to be loaded by grail.el

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
