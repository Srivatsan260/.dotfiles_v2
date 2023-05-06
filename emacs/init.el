;; set.el?
(setq inhibit-startup-message t
      visible-bell nil
      display-line-numbers 'relative)
(setq default-frame-alist '((undecorated . t)))
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-hl-line-mode 0)

;; colorscheme.el
(load-theme 'deeper-blue t)

;; package.el
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(undo-tree evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; undo-tree

(add-to-list 'load-path "~/.emacs.d/plugins")
(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))
(require 'undo-tree)
