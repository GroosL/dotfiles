;;; nano-dark-theme.el --- N Λ N O theme -*- lexical-binding: t -*-

;; Copyright (C) 2021 Free Software Foundation, Inc.

;; Maintainer: Nicolas P. Rougier <Nicolas.Rougier@inria.fr>
;; URL: https://github.com/rougier/nano-theme
;; Version: 0.2.1
;; Package-Requires: ((emacs "27.1"))
;; Keywords: theme, dark, light

;; This file is not part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; N Λ N O theme is a consistent theme that comes in two flavors:
;;  - a light theme that is based on Material (https://material.io/)
;;  - a dark theme that is based on Nord (https://www.nordtheme.com/).
;;
;; A theme is fully defined by a set of (1+6) faces as explained in
;; "On the Design of Text Editors" / https://arxiv.org/abs/2008.06030
;;

;;; Code:
(require 'nano-theme)

(deftheme nano-dark
  "N Λ N O dark theme")


(set-foreground-color nano-dark-foreground)
(set-background-color nano-dark-background)
(nano-theme 'dark)

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'nano-dark)
;;; nano-dark-theme.el ends here
