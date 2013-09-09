;;; Customisation for Emacs in non-batch mode, to be loaded by Grail

(mouse-wheel-mode t)
(column-number-mode t)
;; no bell please
(setq ring-bell-function (lambda ()))

;; don't truncate in vertically split windows
(setq truncate-partial-width-windows nil)

;; Theme

(add-to-list 'zenburn-colors-alist '("zenburn-green-2" . "#4F5F4F"))

(zenburn-with-color-variables
  (custom-theme-set-faces
   'zenburn
   `(region ((t (:foreground ,zenburn-fg :background ,zenburn-fg-1))))
   `(hl-line ((t (:background ,zenburn-green-2))))))

(add-hook 'c-mode-common-hook 'auto-fill-mode)
(add-hook 'c-mode-common-hook 'glasses-mode)

;; The built-in GNU style is broken, fix it
(defconst my-c-style
  '("gnu" (c-offsets-alist . ((arglist-close . c-lineup-arglist)
                              (substatement-open   . 0)
                              (case-label          . 4)
                              (statement-case-open . 0)
                              (block-open          . 0)
                              (knr-argdecl-intro   . -)))))
(c-add-style "Corrected GNU" my-c-style nil)

(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'scroll-left 'disabled nil)

(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

;; SKK
;; SKK が検索する辞書 (サーバを使わないとき)
(setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L")
;; 変換時に註釈 (annotation) を表示する
(setq skk-show-annotation t)
;; 変換候補一覧と注釈 (annotation) を GUI ぽく表示する
(setq skk-show-tooltip t)
;; 注) 今のところ FSF Emacs 21 以上しか対応していません

(when skk-show-tooltip
  ;; tooltip のルックスを指定する。デフォルトでは Emacs 標準のルックスに
  ;; なります。
  (setq skk-tooltip-parameters
        '((background-color . "alice blue")
          (border-color . "royal blue"))))
;; インライン候補表示を使用する
(setq skk-show-inline nil)

(when skk-show-inline
  ;; 変数 skk-treat-candidate-appearance-function を利用して自前で候補に
  ;; 色を付ける場合はこの変数を nil に設定する。
  (setq skk-inline-show-face nil))
;; 候補表示のルックスに関する高度な設定
;;
;; 注1) skk-e21-*-face は FSF Emacs 21 以上のみで存在する face です。それ
;; 以外の Emacsen では別の存在する face に置き換えてください。
;;
;; 注2) 候補の個人辞書への登録においても、`skk-update-jisyo-function' を
;; 設定することで同様のカスタマイズができます。「個人辞書に関する設定」の
;; 例をご覧ください。
(setq skk-treat-candidate-appearance-function
      #'(lambda (candidate listing-p)
          (let* ((value (skk-treat-strip-note-from-word candidate))
                 (cand (car value))
                 (note (cdr value))
                 (sep (if note
                          (propertize (if (skk-annotation-display-p 'list)
                                          " ≒ "
                                        " !")
                                      'face 'skk-e21-latin-face)
                        nil)))
            (cond (note
                   (put-text-property 0 (length cand)
                                      'face 'skk-e21-jisx0201-face cand)
                   (put-text-property 0 (length note)
                                      'face 'skk-e21-katakana-face note)
                   (cons cand (cons sep note)))
                  (t
                   (put-text-property 0 (length cand)
                                      'face 'skk-e21-hiragana-face cand)
                   cand)))))
;; 数値変換機能を使う
(setq skk-use-numeric-conversion t)

;; TODO: migrate that to semantic-default-submodes
;; (semantic-load-enable-gaudy-code-helpers)
(semantic-mode 1)
(global-semantic-idle-completions-mode -1)

;; (enable-visual-studio-bookmarks)
;; (add-to-list 'compilation-finish-functions 'lmcompile-do-highlight)
;; (global-set-key [(control c) (C)] 'lmccompile-clear)

;; (load-library "semantic-hover-completion")
;; (semantic-hover-completion-install-c-hooks)
;; (add-hook 'c-mode-common-hook (lambda () (local-set-key [(meta \?)] 'semantic-hover-completion-popup)))

(global-ede-mode 1)

;; Org mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t)

(setq org-CUA-compatible t)
(setq org-replace-disputed-keys t)
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)

(put 'org-beginning-of-line 'CUA 'move)
(put 'org-end-of-line 'CUA 'move)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Paredit
(require 'paredit-menu)

(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(add-hook 'lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)

(add-hook 'lisp-mode-hook 'highlight-parentheses-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)

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

(load-library "slime-config")

;; Mode-specific info lookup (mostly for ANSI CL)

(require 'info-look)
(info-lookup-add-help
    :mode 'lisp-mode
    :regexp "[^][()'\" \t\n]+"
    :ignore-case t
    :doc-spec '(("(ansicl)Symbol Index" nil nil nil)))

(key-chord-mode 1)

;;; Guess basic indent offsets
(dtrt-indent-mode 1)

;; (global-pabbrev-mode)

(require 'yasnippet)
(add-to-list 'yas/root-directory (expand-file-name "local/snippets" grail-elisp-root))
