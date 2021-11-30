;; Removing useless stuff
(scroll-bar-mode -1)

;; Adding useful stuff
(global-linum-mode t)
(setq make-backup-files nil)

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Customizing useful stuff
(global-set-key (kbd "C-x o") 'find-file)

;; Packages
(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives
	     '("melpa-stable" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
  :ensure t)

(use-package evil
  :ensure t)
(evil-mode 1)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

(use-package neotree
  :ensure t
  :bind (("C-x e" . 'neotree-toggle)))
    (add-hook 'neotree-mode-hook
              (lambda ()
                (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
                (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
                (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
                (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
                (define-key evil-normal-state-local-map (kbd "g") 'neotree-refresh)
                (define-key evil-normal-state-local-map (kbd "n") 'neotree-next-line)
                (define-key evil-normal-state-local-map (kbd "p") 'neotree-previous-line)
                (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
                (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))

(use-package dracula-theme
  :ensure t)

(use-package smartparens
  :ensure t)
(use-package evil-smartparens
  :ensure t
  :config (smartparens-global-mode))

(use-package irony
  :ensure t)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(use-package auto-complete-c-headers
  :ensure t)
(defun my:ac-c-headers-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))

(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(use-package auto-complete-auctex
  :ensure t)
(use-package yasnippet
  :ensure t)
(use-package yasnippet-snippets
  :ensure t)
(use-package latex-preview-pane
  :ensure t)
(add-hook 'LaTeX-mode-hook 'latex-preview-pane-mode)


;; Some melpa stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-list '(("Latex Preview Pane" ("latex-preview-pane-mode") "")))
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#282a36" "#ff5555" "#50fa7b" "#f1fa8c" "#6272a4" "#bd93f9" "#8be9fd" "#f8f8f2"])
 '(custom-enabled-themes '(nano-dark))
 '(custom-safe-themes
   '("37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "bd3b9675010d472170c5d540dded5c3d37d83b7c5414462737b60f44351fb3ed" "aca70b555c57572be1b4e4cec57bc0445dcb24920b12fb1fea5f6baa7f2cad02" "1ca05bdae217adeb636e9bc5e84c8f1d045be2c8004fafd5337d141d9b67a96f" "0ab2aa38f12640ecde12e01c4221d24f034807929c1f859cbca444f7b0a98b3a" default))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(nano-theme org latex-preview-pane auctex helm evil-smartparens dracula-theme neotree which-key evil try use-package))
 '(pdf-latex-command "xelatex")
 '(preview-LaTeX-command-replacements '(latex-preview-pane-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
