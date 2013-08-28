;;; Overrides to make Pallet work with Grail and directories other than ~/.emacs.d

(defun pt/cask-file ()
  "Location of the Cask file."
  (expand-file-name "Cask" grail-elisp-root))

;; We cannot just call (cask-initialize), since it assumes ~/.emacs.d,
;; and similarly we have to fix up pt/cask-up since it calls that
(defun pt/cask-up (&optional body)
  "Attempt to initialize Cask, optionally running BODY."
  (if (file-exists-p (pt/cask-file))
      (progn
	(setq cask-runtime-dependencies '())
	(cask-setup (file-name-directory (pt/cask-file)))
	(epl-initialize)
	(when body (funcall body)))
    (message "No Cask file found. Run `pallet-init' to create one.")))

