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
 '(cedet-android-sdk-root "~/Dev/android-sdk-linux/")
 '(clip-large-size-font t t)
 '(completion-resolve-old-method (quote leave))
 '(completion-tooltip-delay 0)
 '(completion-tooltip-timeout 100)
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes (quote ("dd0c53e873e23298716844777306ab88685278d4d5547efb0bd3f10b50cffef7" "9370aeac615012366188359cb05011aea721c73e1cb194798bc18576025cabeb" "1177fe4645eb8db34ee151ce45518e47cc4595c3e72c55dc07df03ab353ad132" "4c9ba94db23a0a3dea88ee80f41d9478c151b07cb6640b33bfc38be7c2415cc4" "3ad55e40af9a652de541140ff50d043b7a8c8a3e73e2a649eb808ba077e75792" default)))
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.32")
 '(ecb-show-node-info-in-minibuffer (quote ((always . path) (always . name) (always . path) (always . name+type))))
 '(ecb-tip-of-the-day nil)
 '(ecb-tree-buffer-style (quote image))
 '(eclim-eclipse-dirs (quote ("/Applications/eclipse" "/usr/lib/eclipse" "/usr/local/lib/eclipse" "/usr/share/eclipse" "~/Skrivebord/eclipse/")))
 '(eclim-executable (or (executable-find "eclim") (eclim-homedir-executable-find) (eclim-executable-find) "~/Skrivebord/eclipse/eclim/eclim"))
 '(ede-project-directories (quote ("/tmp/edetest")))
 '(ediff-diff-options "")
 '(fast-lock-minimum-size 2000)
 '(fci-rule-color "#383838")
 '(file-cache-assoc-function (quote assoc-ignore-case))
 '(font-lock-beginning-of-syntax-function nil t)
 '(font-lock-keywords-case-fold-search nil t)
 '(font-lock-keywords-only nil t)
 '(font-lock-mark-block-function nil t)
 '(font-lock-maximum-decoration t)
 '(fringe-mode 10 nil (fringe))
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
 '(ispell-dictionary "en_GB" t)
 '(ispell-program-name "/usr/bin/hunspell" t)
 '(jde-jdk-registry (quote (("1.6.0.20" . "/usr/lib/jvm/java-6-sun"))))
 '(jde-key-bindings (list (cons "[? ? ?]" (quote jde-run-menu-run-applet)) (cons "[? ? ?]" (quote jde-build)) (cons "[? ? ?]" (quote jde-compile)) (cons "[? ? ?]" (quote jde-debug)) (cons "[? ? ?]" (quote jde-find)) (cons "[? ? ?]" (quote jde-open-class-at-point)) (cons "[? ? ?]" (quote jde-bsh-run)) (cons "[? ? ?]" (quote jde-gen-println)) (cons "[? ? ?]" (quote jde-help-browse-jdk-doc)) (cons "[? ? ?]" (quote jde-save-project)) (cons "[? ? ?]" (quote jde-wiz-update-class-list)) (cons "[? ? ?]" (quote jde-run)) (cons "[? ? ?]" (quote speedbar-frame-mode)) (cons "[? ? ?]" (quote jde-jdb-menu-debug-applet)) (cons "[? ? ?]" (quote jde-help-symbol)) (cons "[? ? ?]" (quote jde-show-superclass-source)) (cons "[? ? ?]" (quote jde-open-class-at-point)) (cons "[? ? ?]" (quote jde-import-find-and-import)) (cons "[? ? ?e]" (quote jde-wiz-extend-abstract-class)) (cons "[? ? ?f]" (quote jde-gen-try-finally-wrapper)) (cons "[? ? ?i]" (quote jde-wiz-implement-interface)) (cons "[? ? ?j]" (quote jde-javadoc-autodoc-at-line)) (cons "[? ? ?o]" (quote jde-wiz-override-method)) (cons "[? ? ?t]" (quote jde-gen-try-catch-wrapper)) (cons "[? ? ?z]" (quote jde-import-all)) (cons "[? ? ?]" (quote jde-run-etrace-prev)) (cons "[? ? ?]" (quote jde-run-etrace-next)) (cons "[(control c) (control ? )]" (quote jde-complete)) (cons "[(control c) (control v) ?.]" (quote jde-complete-in-line))))
 '(line-number-display-limit-width 1000)
 '(longlines-show-hard-newlines t)
 '(main-line-color1 "#222912")
 '(main-line-color2 "#09150F")
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
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-irc org-mew org-mhe org-rmail org-special-blocks org-vm org-wl org-w3m)))
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
 '(powerline-color1 "#222912")
 '(powerline-color2 "#09150F")
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
 '(save-abbrevs nil)
 '(save-place t nil (saveplace))
 '(scheme-mit-dialect nil)
 '(scheme-program-name "scheme48")
 '(scroll-preserve-screen-position t)
 '(semantic-default-submodes (quote (global-semantic-decoration-mode global-semantic-stickyfunc-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-summary-mode)))
 '(semanticdb-global-mode t nil (semantic/db))
 '(server-done-hook (quote ((lambda nil (delete-frame)))))
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
 '(vc-annotate-background "#2b2b2b")
 '(vc-annotate-color-map (quote ((20 . "#bc8383") (40 . "#cc9393") (60 . "#dfaf8f") (80 . "#d0bf8f") (100 . "#e0cf9f") (120 . "#f0dfaf") (140 . "#5f7f5f") (160 . "#7f9f7f") (180 . "#8fb28f") (200 . "#9fc59f") (220 . "#afd8af") (240 . "#bfebbf") (260 . "#93e0e3") (280 . "#6ca0a3") (300 . "#7cb8bb") (320 . "#8cd0d3") (340 . "#94bff3") (360 . "#dc8cc3"))))
 '(vc-annotate-very-old-color "#dc8cc3")
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
 )
