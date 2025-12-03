;; ------------------------------
;; Package setup
;; ------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq neo-show-hidden-files t)

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

;; ------------------------------
;; UI tweaks (good in terminal)
;; ------------------------------
(setq inhibit-startup-message t)   ;; no startup screen

(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; show line numbers in code
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; remember cursor position in files
(save-place-mode 1)

;; recent files
(recentf-mode 1)
(setq recentf-max-saved-items 200)

;; ------------------------------
;; Neotree (file tree like NerdTree)
;; ------------------------------
(use-package neotree
  :bind
  (("C-c n" . neotree-toggle)))

;; In neotree:
;;  - Enter: open file
;;  - TAB: toggle node
;;  - q: quit

;; ------------------------------
;; Projectile (project navigation)
;; ------------------------------
(use-package projectile
  :init
  (projectile-mode 1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'default))

;; Common commands:
;;  C-c p f  -> projectile-find-file
;;  C-c p p  -> switch project

;; ------------------------------
;; Magit (git porcelain)
;; ------------------------------
(use-package magit
  :bind (("C-x g" . magit-status)))

;; In magit-status:
;;  s -> stage
;;  u -> unstage
;;  c c -> commit
;;  P p -> push
;;  F p -> pull
;;  q -> quit

;; ------------------------------
;; Git blame (per-file)
;; ------------------------------
;; Lightweight option: magit-blame
;; M-x magit-blame-addition (or magit-blame)
;; No extra package needed; magit already installed.

;; ------------------------------
;; Org mode
;; ------------------------------
(use-package org
  :config
  (setq org-startup-indented t
        org-hide-leading-stars t
        org-ellipsis " ▾"))

;; Some handy defaults:
;;  * Heading
;;  ** Subheading
;;  - [ ] Task
;;  - [X] Done
;;
;;  C-c C-t -> cycle TODO state on a heading
;;  C-c .   -> insert timestamp

;; ------------------------------
;; Backup behavior (keep $HOME tidy)
;; ------------------------------
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs.d/auto-saves/" t)))
(make-directory "~/.emacs.d/backups" t)
(make-directory "~/.emacs.d/auto-saves" t)
(global-display-line-numbers-mode 1)
(tab-bar-mode 1)
(add-hook 'focus-out-hook #'save-some-buffers)
(setq require-final-newline t)
(setq neo-window-width 35)
(setq neo-window-fixed-size nil)

