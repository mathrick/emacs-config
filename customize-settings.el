(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-Omega-command "xelatex")
 '(TeX-Omega-mode t)
 '(TeX-PDF-mode t)
 '(TeX-output-view-style (quote (("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$") "%(o?)dvips -t landscape %d -o && gv %f") ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && gv %f") ("^dvi$" ("^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "^landscape$") "%(o?)xdvi %dS -paper a4r -s 0 %d") ("^dvi$" "^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "%(o?)xdvi %dS -paper a4 %d") ("^dvi$" ("^a5\\(?:comb\\|paper\\)$" "^landscape$") "%(o?)xdvi %dS -paper a5r -s 0 %d") ("^dvi$" "^a5\\(?:comb\\|paper\\)$" "%(o?)xdvi %dS -paper a5 %d") ("^dvi$" "^b5paper$" "%(o?)xdvi %dS -paper b5 %d") ("^dvi$" "^letterpaper$" "%(o?)xdvi %dS -paper us %d") ("^dvi$" "^legalpaper$" "%(o?)xdvi %dS -paper legal %d") ("^dvi$" "^executivepaper$" "%(o?)xdvi %dS -paper 7.25x10.5in %d") ("^dvi$" "." "%(o?)xdvi %dS %d") ("^pdf$" "." "evince %o") ("^html?$" "." "netscape %o"))))
 '(auto-compression-mode t nil (jka-compr))
 '(auto-insert t)
 '(auto-insert-alist (quote ((("\\.\\([Hh]\\|hh\\|hpp\\)\\'" . "C / C++ header") (upcase (concat (file-name-nondirectory (substring buffer-file-name 0 (match-beginning 0))) "_" (substring buffer-file-name (1+ (match-beginning 0))))) "#ifndef " str "
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
 '(auto-insert-mode t)
 '(bell-inhibit-time 2)
 '(blink-cursor-delay 0)
 '(blink-cursor-interval 0.5)
 '(blink-matching-paren nil)
 '(c-default-style (quote ((java-mode . "java") (other . "Corrected gnu"))))
 '(case-fold-search t)
 '(cedet-android-sdk-root "~/Dev/android-sdk-linux/")
 '(clip-large-size-font t t)
 '(column-number-mode t)
 '(completion-resolve-old-method (quote leave))
 '(completion-tooltip-delay 0)
 '(completion-tooltip-timeout 100)
 '(cua-auto-tabify-rectangles nil)
 '(cua-enable-cua-keys nil)
 '(cua-enable-cursor-indications t)
 '(cua-enable-modeline-indications nil)
 '(cua-enable-region-auto-help t)
 '(cua-mode t nil (cua-base))
 '(current-language-environment "UTF-8")
 '(custom-file "~/.emacs-custom")
 '(default-justification (quote left))
 '(diff-switches "-u")
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.32")
 '(ecb-show-node-info-in-minibuffer (quote ((always . path) (always . name) (always . path) (always . name+type))))
 '(ecb-tip-of-the-day nil)
 '(ecb-tree-buffer-style (quote image))
 '(eclim-eclipse-dirs (quote ("/Applications/eclipse" "/usr/lib/eclipse" "/usr/local/lib/eclipse" "/usr/share/eclipse" "~/Skrivebord/eclipse/")))
 '(eclim-executable (or (executable-find "eclim") (eclim-homedir-executable-find) (eclim-executable-find) "~/Skrivebord/eclipse/eclim/eclim"))
 '(ede-project-directories (quote ("/tmp/edetest")))
 '(ediff-custom-diff-options "-u")
 '(ediff-diff-options "")
 '(fast-lock-minimum-size 2000)
 '(file-cache-assoc-function (quote assoc-ignore-case))
 '(font-lock-beginning-of-syntax-function nil t)
 '(font-lock-keywords-case-fold-search nil t)
 '(font-lock-keywords-only nil t)
 '(font-lock-mark-block-function nil t)
 '(font-lock-maximum-decoration t)
 '(glasses-face (quote bold))
 '(glasses-original-separator "")
 '(glasses-separator "")
 '(global-cwarn-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(global-hl-line-mode t)
 '(global-semantic-decoration-mode t nil (semantic/decorate))
 '(global-semantic-highlight-edits-mode nil nil (semantic/util-modes))
 '(global-semantic-idle-completions-mode nil nil (semantic/idle))
 '(global-semantic-idle-scheduler-mode t nil (semantic/idle))
 '(global-semantic-idle-summary-mode t nil (semantic/idle))
 '(global-semantic-show-parser-state-mode nil nil (semantic/util-modes))
 '(global-semantic-show-unmatched-syntax-mode nil nil (semantic/util-modes))
 '(global-semantic-stickyfunc-mode t nil (semantic/util-modes))
 '(global-senator-minor-mode t nil (semantic/senator))
 '(global-srecode-minor-mode t nil (srecode))
 '(gnuserv-program (concat exec-directory "/gnuserv"))
 '(highlight-completion-list-external (quote (t t t t t t t t t t)))
 '(highlight-wrong-size-font nil t)
 '(icomplete-minibuffer-setup-hook (quote ((lambda nil (make-local-variable (quote max-mini-window-height)) (setq max-mini-window-height 3)))))
 '(icomplete-mode t)
 '(ido-auto-merge-work-directories-length -1)
 '(ido-confirm-unique-completion t)
 '(ido-create-new-buffer (quote always))
 '(ido-default-buffer-method (quote selected-window))
 '(ido-default-file-method (quote selected-window))
 '(image-file-name-extensions (quote ("png" "jpeg" "jpg" "gif" "tiff" "tif" "xbm" "xpm" "pbm" "pgm" "ppm" "pnm" "svg" "pdf")))
 '(imaxima-scale-factor 1.0)
 '(imaxima-use-maxima-mode-flag t)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inferior-lisp-program "sbcl")
 '(ispell-dictionary "en_GB")
 '(ispell-program-name "/usr/bin/hunspell")
 '(jde-jdk-registry (quote (("1.6.0.20" . "/usr/lib/jvm/java-6-sun"))))
 '(jde-key-bindings (list (cons "[? ? ?]" (quote jde-run-menu-run-applet)) (cons "[? ? ?]" (quote jde-build)) (cons "[? ? ?]" (quote jde-compile)) (cons "[? ? ?]" (quote jde-debug)) (cons "[? ? ?]" (quote jde-find)) (cons "[? ? ?]" (quote jde-open-class-at-point)) (cons "[? ? ?]" (quote jde-bsh-run)) (cons "[? ? ?]" (quote jde-gen-println)) (cons "[? ? ?]" (quote jde-help-browse-jdk-doc)) (cons "[? ? ?]" (quote jde-save-project)) (cons "[? ? ?]" (quote jde-wiz-update-class-list)) (cons "[? ? ?]" (quote jde-run)) (cons "[? ? ?]" (quote speedbar-frame-mode)) (cons "[? ? ?]" (quote jde-jdb-menu-debug-applet)) (cons "[? ? ?]" (quote jde-help-symbol)) (cons "[? ? ?]" (quote jde-show-superclass-source)) (cons "[? ? ?]" (quote jde-open-class-at-point)) (cons "[? ? ?]" (quote jde-import-find-and-import)) (cons "[? ? ?e]" (quote jde-wiz-extend-abstract-class)) (cons "[? ? ?f]" (quote jde-gen-try-finally-wrapper)) (cons "[? ? ?i]" (quote jde-wiz-implement-interface)) (cons "[? ? ?j]" (quote jde-javadoc-autodoc-at-line)) (cons "[? ? ?o]" (quote jde-wiz-override-method)) (cons "[? ? ?t]" (quote jde-gen-try-catch-wrapper)) (cons "[? ? ?z]" (quote jde-import-all)) (cons "[? ? ?]" (quote jde-run-etrace-prev)) (cons "[? ? ?]" (quote jde-run-etrace-next)) (cons "[(control c) (control ? )]" (quote jde-complete)) (cons "[(control c) (control v) ?.]" (quote jde-complete-in-line))))
 '(line-number-display-limit-width 1000)
 '(longlines-show-hard-newlines t)
 '(mouse-avoidance-mode (quote exile) nil (avoid))
 '(mouse-avoidance-nudge-dist 35)
 '(mouse-avoidance-threshold 15)
 '(mouse-sel-mode nil)
 '(mouse-wheel-follow-mouse t)
 '(msb-mode t)
 '(msf-abbrev-indent-after-expansion t)
 '(msf-abbrev-root "/home/mathrick/elisp/mode-abbrevs")
 '(ogonek-from-encoding "windows-PL")
 '(ogonek-to-encoding "iso8859-2")
 '(org-bullets-bullet-list (quote ("✸" "✿" "◉" "○")))
 '(org-cycle-emulate-tab (quote whitestart))
 '(org-disputed-keys (quote (([(shift up)] . [(meta p)]) ([(shift down)] . [(meta n)]) ([(shift left)] . [(meta -)]) ([(shift right)] . [(meta +)]) ([(meta left)] . [(super left)]) ([(meta right)] . [(super right)]) ([(meta up)] . [(super up)]) ([(meta down)] . [(super down)]) ([(control shift right)] . [(meta shift +)]) ([(control shift left)] . [(meta shift -)]))))
 '(org-export-latex-classes (quote (("article" "\\documentclass[a4paper,11pt]{article}
%\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{soul}
\\usepackage{hyperref}" ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}") ("\\paragraph{%s}" . "\\paragraph*{%s}") ("\\subparagraph{%s}" . "\\subparagraph*{%s}")) ("report" "\\documentclass[11pt]{report}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{soul}
\\usepackage{hyperref}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) ("book" "\\documentclass[11pt]{book}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{soul}
\\usepackage{hyperref}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) ("reportflat" "\\documentclass[11pt]{report}
%\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{soul}
\\usepackage[colorlinks=false]{hyperref}" ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}") ("\\paragraph{%s}" . "\\paragraph*{%s}")) ("beamer" "\\documentclass{beamer}" org-beamer-sectioning))))
 '(org-export-latex-default-packages-alist (quote (("T1" "fontenc" t) ("" "fixltx2e" nil) ("" "graphicx" t) ("" "longtable" nil) ("" "float" nil) ("" "wrapfig" nil) ("" "soul" t) ("" "t1enc" t) ("" "textcomp" t) ("" "marvosym" t) ("" "wasysym" t) ("" "latexsym" t) ("" "amssymb" t) ("" "hyperref" nil) "\\tolerance=1000")))
 '(org-export-latex-title-command "\\maketitle")
 '(org-format-latex-header "\\documentclass{article}
\\usepackage[english]{babel}
\\usepackage[utf8]{inputenc}
\\DeclareUnicodeCharacter{03A9}{\\Omega}
\\usepackage{graphicx}
\\usepackage{fullpage}         % do not remove
\\usepackage{amssymb}
\\usepackage[usenames]{color}
\\usepackage{amsmath}
\\usepackage{latexsym}
\\usepackage[mathscr]{eucal}
\\pagestyle{empty}             % do not remove")
 '(org-hide-leading-stars t)
 '(org-latex-to-pdf-process (quote ("latexify.sh %f")))
 '(org-odd-levels-only t)
 '(org-pretty-entities t)
 '(org-todo-keywords (quote ((sequence "TODO" "DONE") (sequence "BUG" "WISHLIST" "|" "FIXED" "WONTFIX" "NOTABUG") (sequence "PENDING" "REPEAT" "|" "FAILED" "SUCCESS"))))
 '(pabbrev-global-mode-excluded-modes (quote (shell-mode custom-mode dired-mode telnet-mode c-mode)))
 '(pabbrev-global-mode-not-buffer-names (quote ("*Messages*")))
 '(pabbrev-idle-timer-verbose nil)
 '(paren-dont-load-timer nil)
 '(paren-dont-touch-blink nil)
 '(paren-sexp-mode (quote mismatch))
 '(pascal-auto-lineup (quote (all)))
 '(pascal-auto-newline nil)
 '(pascal-tab-always-indent t)
 '(preview-LaTeX-command (quote ("%`%l \"\\nonstopmode\\nofiles\\PassOptionsToPackage{" ("," . preview-required-option-list) "}{preview}\\AtBeginDocument{\\ifx\\ifPreview\\undefined" preview-default-preamble "\\fi}\"%' %t")))
 '(preview-required-option-list (quote ("active" "tightpage" "auctex" (preview-preserve-counters "counters") "pdftex")))
 '(prolog-system (quote swi))
 '(py-imenu-show-method-args-p t)
 '(rails-ws:port "3001")
 '(recentf-mode t)
 '(redshank-accessor-name-function (quote redshank-accessor-name/%))
 '(redshank-canonical-slot-name-function (quote redshank-canonical-slot-name/%))
 '(rw-hunspell-default-dictionary "en_GB")
 '(rw-hunspell-dicpath-list (quote ("/usr/share/hunspell" "/usr/share/myspell")))
 '(rw-hunspell-make-dictionary-menu t)
 '(rw-hunspell-use-rw-ispell t)
 '(safe-local-variable-values (quote ((js-indent-level . 4) (encoding . utf-8) (package . F2CL) (Package . F2CL) (Package . Maxima) (Package . containers) (Package . LINJ) (pbook-monochrome . t) (pbook-style . article) (pbook-use-toc . t) (pbook-author . "Luke Gorrie, with modifications by Paul Khuong") (Package . CCL) (indent-tabs) (Encoding . utf-8) (show-trailing-whitespace . t) (Readtable . GLISP) (Package . SGML) (Package . LALR) (Package . DRAKMA) (Package . metabang\.moptilities) (Package . CXML) (readtable . runes) (Package . computed-class) (Package . CL-INTERPOL) (Package . CLIMACS-JAVA-SYNTAX) (Package . CLIMACS-GUI) (Package . CLIMACS-C-SYNTAX) (Package . CLIMACS-LISP-SYNTAX) (Package . CLIMACS) (Package . CLIMACS-COMMANDS) (Package . COMMON-LISP-USER) (Package . CLIMACS-PROLOG-SYNTAX) (Package . DREI-LISP-SYNTAX) (Package . DREI-SYNTAX) (Package . CLIM-POSTSCRIPT) (Package . CLIM-CLX) (Lowercase . T) (Package . Xlib) (Log . clx\.log) (Package . AUTOMATON) (Package . GOATEE) (Package . CLIMI) (readtable . py-ast-user-readtable) (package . clpython) (readtable . py-user-readtable) (package . clpython\.parser) (readtable . py-ast-readtable) (Package . bind) (syntax . ANSI-COMMON-LISP) (Package SERIES :use "COMMON-LISP" :colon-mode :external) (Package . CHUNGA) (Package . FLEXI-STREAMS) (package . puri) (syntax . COMMON-LISP) (Package ITERATE :use "COMMON-LISP" :colon-mode :external) (Package . DREI-COMMANDS) (Package . clim-internals) (Package . DREI) (Package . DREI-EDITING) (Package . User) (Package . MCCLIM-FREETYPE) (Package . ESA) (Package . CLIM-INTERNALS) (Indent-tabs-mode . NIL) (movitz-mode . t) (Package . CL-PPCRE) (Syntax . ANSI-Common-Lisp) (Syntax . Common-lisp) (Package . XLIB) (Lowercase . Yes) (Syntax . Common-Lisp) (py-indent-offset . 4) (Package . CL-USER) (Package . HUNCHENTOOT) (package . net\.html\.generator) (unibyte . t) (Syntax . COMMON-LISP) (Package . CL-WHO) (Base . 10))))
 '(save-place t nil (saveplace))
 '(scheme-mit-dialect nil)
 '(scheme-program-name "scheme48")
 '(scroll-preserve-screen-position t)
 '(semanticdb-global-mode t nil (semantic/db))
 '(server-done-hook (quote ((lambda nil (delete-frame)))))
 '(server-window (lambda (buf) (let ((pop-up-frames t)) (display-buffer buf))))
 '(show-paren-mode t)
 '(show-paren-style (quote mixed))
 '(skk-henkan-show-candidates-keys (quote (48 49 50 51 52 53 54 55 56 57 \.\.\.)))
 '(skk-server-host nil t)
 '(skk-server-inhibit-startup-server t)
 '(skk-server-prog nil)
 '(skk-show-inline t t)
 '(slime-autodoc-use-multiline-p t)
 '(slime-complete-symbol*-fancy t)
 '(slime-enable-evaluate-in-emacs t)
 '(split-width-threshold 360)
 '(sql-database "BDLAB")
 '(sql-user "mathrick")
 '(srecode-insert-ask-variable-method (quote ask))
 '(todoo-sub-item-marker "-")
 '(tool-bar-mode nil)
 '(tooltip-gud-modes (quote (gud-mode c-mode c++-mode pascal-mode)))
 '(tooltip-gud-tips-p nil)
 '(tooltip-use-echo-area nil)
 '(truncate-lines t)
 '(undo-limit 200000)
 '(undo-strong-limit 300000)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(uniquify-trailing-separator-p nil)
 '(vc-diff-switches (quote ("-u")))
 '(viper-keep-point-on-repeat nil)
 '(wdired-enable t)
 '(wdired-use-interactive-rename nil)
 '(which-function-mode nil)
 '(windmove-wrap-around t)
 '(x-select-enable-clipboard t)
 '(x-symbol-initialize nil)
 '(yas/use-menu (quote abbreviate))
 '(yas/wrap-around-region (quote cua)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#ffffff" :foreground "#000000" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "Envy Code R"))))
 '(diff-added ((t (:background "#98eb98" :foreground "black"))))
 '(diff-changed ((t (:foreground "MediumBlue"))))
 '(diff-context ((t (:foreground "Black"))))
 '(diff-file-header ((t (:foreground "Red" :background "White"))))
 '(diff-header ((t (:foreground "Red"))))
 '(diff-hunk-header ((t (:background "darkmagenta" :foreground "White"))))
 '(diff-index ((t (:foreground "Green"))))
 '(diff-nonexistent ((t (:foreground "DarkBlue"))))
 '(diff-removed ((t (:background "#d08080" :foreground "black"))))
 '(flashcard-answer-face ((t (:background "black" :foreground "green" :height 5.0))))
 '(flashcard-input-correct-face ((t (:foreground "forest green" :weight bold))))
 '(flashcard-input-face ((t (:foreground "blue3" :weight bold))))
 '(flashcard-question-face ((t (:background "black" :foreground "cornsilk" :height 5.0))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background light)) (:foreground "Purple" :weight bold))))
 '(fringe ((((class color) (background light)) (:background "grey95" :family "8x13"))))
 '(highlight-current-line-face ((t (:background "light cyan"))) t)
 '(hl-paren-face ((t (:weight ultra-bold))) t)
 '(mode-line ((t (:background "#B8860B" :foreground "white" :overline "#FFD700" :underline "#FFD700"))))
 '(msf-fld-field-face ((t (:inherit font-lock-warning-face))))
 '(org-hide ((t (:foreground "white"))))
 '(uim-preedit-highlight-face ((t (:stipple nil :background "White" :foreground "Blue3" :inverse-video nil :box nil \.\.\.))) t))
