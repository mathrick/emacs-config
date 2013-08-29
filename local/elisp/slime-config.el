;;; Conditional loading of Quicklisp-provided SLIME

(let ((slime (expand-file-name "~/quicklisp/slime-helper.el")))
  (if (file-exists-p slime)
      (load slime)
    (warn "No Quicklisp SLIME installation found. Remember to install that!")))

(setq load-path (remove "/usr/share/emacs-snapshot/site-lisp/slime" load-path))

(eval-after-load "slime-helper"
  (lambda ()
    (require 'slime)
    (slime-setup '(slime-fancy slime-indentation slime-asdf 
                               slime-mrepl slime-media ;; slime-mdot-fu
                               ))))
