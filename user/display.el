;;; Customisation for Emacs in non-batch mode, to be loaded by Grail

(mouse-wheel-mode t)
(column-number-mode t)
(global-undo-tree-mode 1)
;; no bell please
(setq ring-bell-function (lambda ()))
(setq bell-inhibit-time 2)

;;; Parens and cursor
(setq blink-cursor-delay 0)
(setq blink-cursor-interval 0.5)
(setq blink-matching-paren nil)
(setq column-number-mode t)

;; don't truncate in vertically split windows
(setq truncate-partial-width-windows nil)

;;; CUA
(setq cua-auto-tabify-rectangles nil)
(setq cua-enable-cua-keys nil)
(setq cua-enable-cursor-indications t)
(setq cua-enable-modeline-indications nil)
(setq cua-enable-region-auto-help t)
(cua-mode)

;; Theme
(load-theme 'zenburn)
(eval-after-load 'zenburn-theme
  '(progn
     (add-to-list 'zenburn-colors-alist '("zenburn-green-2" . "#4F5F4F"))

     (zenburn-with-color-variables
       (custom-theme-set-faces
	'zenburn
	`(region ((t (:foreground ,zenburn-fg :background ,zenburn-fg-1))))
	`(hl-line ((t (:background ,zenburn-green-2))))))))

(setq glasses-face 'bold)
(setq glasses-original-separator "")
(setq glasses-separator "")

(add-hook 'c-mode-common-hook 'auto-fill-mode)
(add-hook 'c-mode-common-hook 'glasses-mode)

(global-cwarn-mode)

(global-font-lock-mode)

(global-hl-line-mode)

;; The built-in GNU style is broken, fix it
(defconst my-c-style
  '("gnu" (c-offsets-alist . ((arglist-close . c-lineup-arglist)
                              (substatement-open   . 0)
                              (case-label          . 4)
                              (statement-case-open . 0)
                              (block-open          . 0)
                              (knr-argdecl-intro   . -)))))
(c-add-style "Corrected GNU" my-c-style nil)
(setq c-default-style '((java-mode . "java")
                        (csharp-mode . "c#")
                        (other . "Corrected gnu")))

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

(global-semantic-decoration-mode)            
(global-semantic-highlight-edits-mode)       
(global-semantic-highlight-func-mode)        
(global-semantic-idle-completions-mode)      
(global-semantic-idle-scheduler-mode)        
(global-semantic-idle-summary-mode)          
(global-semantic-show-parser-state-mode)     
(global-semantic-show-unmatched-syntax-mode) 
(global-semantic-stickyfunc-mode)            

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

(setq org-modules '(org-bbdb
                    org-bibtex
                    org-docview
                    org-gnus
                    org-info
                    org-jsinfo
                    org-irc
                    org-mew
                    org-mhe
                    org-rmail
                    org-special-blocks
                    org-vm
                    org-wl
                    org-w3m))

(setq org-todo-keywords '((sequence "TODO" "DONE")
                          (sequence "BUG" "WISHLIST" "|" "FIXED" "WONTFIX" "NOTABUG")
                          (sequence "PENDING" "REPEAT" "|" "FAILED" "SUCCESS")))

(put 'org-beginning-of-line 'CUA 'move)
(put 'org-end-of-line 'CUA 'move)

(setq org-bullets-bullet-list '("✸" "✿" "◉" "○"))

(setq org-hide-leading-stars t)
(setq org-odd-levels-only t)
(setq org-pretty-entities t)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Smartparens
(require 'smartparens-config)

(smartparens-global-strict-mode)

(add-hook 'lisp-mode-hook 'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)

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

;;; OmniSharp
(add-hook 'csharp-mode-hook 'omnisharp-mode)
(add-hook 'csharp-mode-hook 'eldoc-mode)

;;; Auto-insert
(setq auto-insert t)
(setq auto-insert-alist (quote ((("\\.\\([Hh]\\|hh\\|hpp\\)\\'" . "C / C++ header") (upcase (concat (file-name-nondirectory (substring buffer-file-name 0 (match-beginning 0))) "_" (substring buffer-file-name (1+ (match-beginning 0))))) "#ifndef " str "

#define " str "

" _ "

#endif") (("\\.\\([Cc]\\|cc\\|cpp\\)\\'" . "C / C++ program") nil "#include \"" (let ((stem (file-name-sans-extension buffer-file-name))) (cond ((file-exists-p (concat stem ".h")) (file-name-nondirectory (concat stem ".h"))) ((file-exists-p (concat stem ".hh")) (file-name-nondirectory (concat stem ".hh"))))) & 34 | -10) (("[Mm]akefile\\'" . "Makefile") . "makefile.inc") (html-mode lambda nil (sgml-tag "html")) (plain-tex-mode . "tex-insert.tex") (bibtex-mode . "tex-insert.tex") (latex-mode "options, RET: " "\\documentclass[" str & 93 | -1 123 (read-string "class: ") "}
" ("package, %s: " "\\usepackage[" (read-string "options, RET: ") & 93 | -1 123 str "}
") _ "
\\begin{document}
" _ "
\\end{document}") (("/bin/.*[^/]\\'" . "Shell-Script mode magic number") lambda nil (if (eq major-mode default-major-mode) (sh-mode))) (ada-mode . ada-header) (("\\.[1-9]\\'" . "Man page skeleton") "Short description: " ".\\\" Copyright (C), " (substring (current-time-string) -4) "  " (getenv "ORGANIZATION") | (progn user-full-name) "
.\\\" You may distribute this file under the terms of the GNU Free
.\\\" Documentation License.
.TH " (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) " " (file-name-extension (buffer-file-name)) " " (format-time-string "%Y-%m-%d ") "
.SH NAME
" (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) " \\- " str "
.SH SYNOPSIS
.B " (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) "
" _ "
.SH DESCRIPTION
.SH OPTIONS
.SH FILES
.SH \"SEE ALSO\"
.SH BUGS
.SH AUTHOR
" (user-full-name) (quote (if (search-backward "&" (line-beginning-position) t) (replace-match (capitalize (user-login-name)) t t))) (quote (end-of-line 1)) " <" (progn user-mail-address) ">
") (("\\.el\\'" . "Emacs Lisp header") "Short description: " ";;; " (file-name-nondirectory (buffer-file-name)) " --- " str "

;; Copyright (C) " (substring (current-time-string) -4) "  " (getenv "ORGANIZATION") | (progn user-full-name) "

;; Author: " (user-full-name) (quote (if (search-backward "&" (line-beginning-position) t) (replace-match (capitalize (user-login-name)) t t))) (quote (end-of-line 1)) " <" (progn user-mail-address) ">
;; Keywords: " (quote (require (quote finder))) (quote (setq v1 (mapcar (lambda (x) (list (symbol-name (car x)))) finder-known-keywords) v2 (mapconcat (lambda (x) (format "%12s:  %s" (car x) (cdr x))) finder-known-keywords "
"))) ((let ((minibuffer-help-form v2)) (completing-read "Keyword, C-h: " v1 nil t)) str ", ") & -2 "

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, version 2.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; " _ "

;;; Code:



(provide '" (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) ")
;;; " (file-name-nondirectory (buffer-file-name)) " ends here
") (("\\.texi\\(nfo\\)?\\'" . "Texinfo file skeleton") "Title: " "\\input texinfo   @c -*-texinfo-*-
@c %**start of header
@setfilename " (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) ".info
" "@settitle " str "
@c %**end of header
@copying
" (setq short-description (read-string "Short description: ")) ".

" "Copyright @copyright{} " (substring (current-time-string) -4) "  " (getenv "ORGANIZATION") | (progn user-full-name) "

@quotation
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.2
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover
Texts.  A copy of the license is included in the section entitled ``GNU
Free Documentation License''.

A copy of the license is also available from the Free Software
Foundation Web site at @url{http://www.gnu.org/licenses/fdl.html}.

@end quotation

The document was typeset with
@uref{http://www.texinfo.org/, GNU Texinfo}.

@end copying

@titlepage
@title " str "
@subtitle " short-description "
@author " (getenv "ORGANIZATION") | (progn user-full-name) " <" (progn user-mail-address) ">
@page
@vskip 0pt plus 1filll
@insertcopying
@end titlepage

@c Output the table of the contents at the beginning.
@contents

@ifnottex
@node Top
@top " str "

@insertcopying
@end ifnottex

@c Generate the nodes for this menu with `C-c C-u C-m'.
@menu
@end menu

@c Update all node entries with `C-c C-u C-n'.
@c Insert new nodes with `C-c C-c n'.
@node Chapter One
@chapter Chapter One

" _ "

@node Copying This Manual
@appendix Copying This Manual

@menu
* GNU Free Documentation License::  License for copying this manual.
@end menu

@c Get fdl.texi from http://www.gnu.org/licenses/fdl.html
@include fdl.texi

@node Index
@unnumbered Index

@printindex cp

@bye

@c " (file-name-nondirectory (buffer-file-name)) " ends here
"))))

(setq auto-insert-mode t)

