;;; latex-preview-pane-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "latex-preview-pane" "latex-preview-pane.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from latex-preview-pane.el

(autoload 'latex-preview-pane-enable "latex-preview-pane" "\
Enable `latex-preview-pane-mode' in `latex-mode'." nil nil)

(autoload 'init-latex-preview-pane "latex-preview-pane" nil nil nil)

(autoload 'latex-preview-update "latex-preview-pane" nil t nil)

(autoload 'latex-preview-pane-update "latex-preview-pane" nil t nil)

(autoload 'latex-preview-pane-update-p "latex-preview-pane" nil nil nil)

(autoload 'latex-preview-pane-mode "latex-preview-pane" "\
Toggle Latex Preview Pane Mode.
     Interactively with no argument, this command toggles the mode.
     A positive prefix argument enables the mode, any other prefix
     argument disables it.  From Lisp, argument omitted or nil enables
     the mode, `toggle' toggles the state.
     
     When Latex Preview Pane mode is enabled, saving a latex file will cause 
     a PDF preview pane of your document to appear.

If called interactively, enable Latex-Preview-Pane mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "latex-preview-pane" '("latex-p" "lpp/" "pdf-latex-command" "preview-orientation" "shell-escape-mode")))

;;;***

;;;### (autoloads nil nil ("latex-preview-pane-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; latex-preview-pane-autoloads.el ends here
