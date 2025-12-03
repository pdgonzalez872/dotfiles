;; ------------------------------
;; Package setup
;; ------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

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
(global-display-line-numbers-mode 1)

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
  (("C-c n" . neotree-toggle))
  :config
  ;; show dotfiles, set width, allow resizing
  (setq neo-show-hidden-files t
        neo-window-width 35
        neo-window-fixed-size nil)

  ;; Recursively expand all directories in Neotree
  (defun my/neotree-expand-all ()
    "Recursively expand all directories in the current Neotree buffer."
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (while (not (eobp))
        (let ((path (neo-buffer--get-filename-current-line)))
          (when (and path (file-directory-p path))
            (neotree-expand-node)))
        (forward-line 1))))

  ;; Recursively collapse all directories in Neotree
  (defun my/neotree-collapse-all ()
    "Recursively collapse all directories in the current Neotree buffer."
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (while (not (eobp))
        (let ((path (neo-buffer--get-filename-current-line)))
          (when (and path (file-directory-p path))
            (neotree-collapse-node)))
        (forward-line 1))))

  ;; Bind keys inside Neotree
  (define-key neotree-mode-map (kbd "E") #'my/neotree-expand-all)
  (define-key neotree-mode-map (kbd "C") #'my/neotree-collapse-all))

;; In neotree:
;;  - TAB: toggle node
;;  - RET: open file
;;  - E: expand all directories (custom)
;;  - C: collapse all directories (custom)
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

;; ------------------------------
;; Tabs, saving behavior, final newline
;; ------------------------------
(tab-bar-mode 1)

;; Save all modified buffers when Emacs loses focus
(add-hook 'focus-out-hook #'save-some-buffers)

;; Always ensure file ends with a newline on save
(setq require-final-newline t)
