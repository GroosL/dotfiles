;;; recently-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "recently" "recently.el" (0 0 0 0))
;;; Generated autoloads from recently.el

(defvar recently-mode nil "\
Non-nil if Recently mode is enabled.
See the `recently-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `recently-mode'.")

(custom-autoload 'recently-mode "recently" nil)

(autoload 'recently-mode "recently" "\
Track recently opened files.
When enabled it records recently opened file paths, and
view list and visit again via `recently-show' command.

If called interactively, enable Recently mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'recently-show "recently" "\
Show buffet that lists recently opened files.
BUFFER-NAME, if given, should be a string for buffer to create.

\(fn &optional BUFFER-NAME)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "recently" '("recently-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; recently-autoloads.el ends here
