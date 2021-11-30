;;; xwidgets-reuse-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "xwidgets-reuse" "xwidgets-reuse.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from xwidgets-reuse.el

(autoload 'xwidgets-reuse-register-minor-mode "xwidgets-reuse" "\
Registers a MINOR-MODE with xwidgets-reuse.
This minor mode will automatically be turned off when another minor mode from
`xwidgets-reuse--xwidgets-specialization-minor-modes' is used through
`xwidgets-reuse-xwidget-reuse-browse-url'.

\(fn MINOR-MODE)" nil nil)

(autoload 'xwidgets-reuse-xwidget-reuse-browse-url "xwidgets-reuse" "\
Open URL using xwidgets, reusing an existing xwidget buffer if possible.
Optional argument USE-MINOR-MODE is a minor mode to be activated
in the xwidgets session (e.g., for custom keybindings).

\(fn URL &optional USE-MINOR-MODE)" t nil)

(autoload 'xwidgets-reuse-xwidget-external-browse-current-url "xwidgets-reuse" "\
Externally browse url shown in current xwidget session." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "xwidgets-reuse" '("xwidgets-reuse-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; xwidgets-reuse-autoloads.el ends here
