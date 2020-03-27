;; custom variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("41c8c11f649ba2832347fe16fe85cf66dafe5213ff4d659182e25378f9cfc183" default)))
 '(global-nlinum-mode t)
 '(nlinum-format "%4d ")
 '(nlinum-highlight-current-line t)
 '(package-selected-packages
   (quote
    (company-quickhelp omnisharp flycheck-inline flycheck-color-mode-line flycheck company ssh-agency nlinum helm-swoop helm magit git-timemachine golden-ratio crux smart-mode-line highlight-numbers dracula-theme darcula-theme visual-regexp-steroids visual-regexp expand-region use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :height 113 :family "Fira Code")))))

;; MELPA setup
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; use-package installation
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; install package if not present with use-package
(setq use-package-always-ensure t)

;; update any change made on file to the current buffer
(global-auto-revert-mode)

;; expand region based
(use-package expand-region
  :commands er/expand-region
  :bind ("M-m" . er/expand-region))

;; replace search and replace with regex
;; use sane regex instead of defaults one (no need to escape group parentheses)
(use-package visual-regexp)
(use-package visual-regexp-steroids
  :requires visual-regexp
  :bind (("C-c r" . vr/replace)
         ("M-%" . vr/query-replace)))

;; follow symbolic links without being prompted
(setq vc-follow-symlinks t)

;; better kill line
(use-package crux
  :bind
  (("C-k" . crux-smart-kill-line)))

;; disable inserting tabs
(setq-default indent-tabs-mode nil)
(setq-default tabs-width 0)

;; short answers for yes/no questions
(fset 'yes-or-no-p 'y-or-n-p)

;; easily navigate in file history
(use-package git-timemachine)

;;; magit, the all-in-one git interface
(use-package magit
  :config
  (set-default 'magit-stage-all-confirm nil)
  (global-unset-key (kbd "C-x g"))
  :hook
  (magit-mode . magit-load-config-extensions)
  :bind
  (("C-x g s" . magit-status)
   ("C-x g h" . magit-log)
   ("C-x g f" . magit-file-log)
   ("C-x g b" . magit-blame-mode)
   ("C-x g m" . magit-branch-manager)
   ("C-x g c" . magit-branch)
   ("C-x g s" . magit-status)
   ("C-x g r" . magit-reflog)))

;; full screen magit-status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(if (eq system-type 'windows-nt)
    (use-package ssh-agency)
    (setenv "GIT_ASKPASS" "git-gui--askpass")
  )

;;; helm setup
(use-package helm
  :bind (
         ("C-x C-b" . 'helm-buffers-list)
         ("C-c f" . 'helm-recentf)
         ("C-x C-f" . 'helm-find-files)
         ("M-x" . 'helm-M-x)
         ("M-y" . 'helm-show-kill-ring)
         ("C-c i" . 'helm-imenu)
         ("C-x b" . 'helm-mini))
  :bind (:map helm-map
              ("<tab>" . helm-execute-persistent-action)
              ("C-i" . helm-execute-persistent-action) ; make TAB work in terminal
              ("M-i" . helm-previous-line)
              ("M-k" . helm-next-line)
              ("M-I" . helm-previous-page)
              ("M-K" . helm-next-page)
              ("M-h" . helm-beginning-of-buffer)
              ("M-H" . helm-end-of-buffer))
  :config
  (setq helm-buffers-fuzzy-matching t
        helm-move-to-line-cycle-in-source t
        helm-ff-file-name-history-use-recentf t)
  ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
  ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
  ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))
  (helm-mode 1))

(use-package helm-swoop
  :bind ("M-M" . helm-swoop))

;;; company, autocompletion
(use-package company
  :bind ("C-c c" . company-complete-common)
  :config
  (global-company-mode))

;; display documentation popup on autocomplete
(use-package company-quickhelp
  :requires company
  :config
  (company-quickhelp-mode)
  :hook
  (lsp-mode . company-quickhelp-mode))

;;; flycheck, linter
(use-package flycheck
  :hook (prog-mode . flycheck-mode))

(use-package flycheck-color-mode-line
  :requires flycheck
  :hook (flycheck-mode . flycheck-color-mode-line))

(use-package flycheck-inline
  :requires flycheck
  :hook (flycheck-mode . flycheck-inline-mode))

;;; Programming

;; lsp
(use-package lsp-mode
  :commands lsp
  :hook (python-mode . lsp))

(use-package lsp-ui
  :requires lsp-mode
  :commands lsp-ui-mode)

(use-package company-lsp
  :requires lsp-mode
  :commands company-lsp)

;; c#
(use-package omnisharp
  :requires (company flycheck)
  :hook
  (csharp-mode . omnisharp-mode)
  :config
  (add-to-list 'company-backends 'company-omnisharp))

;; Markdown
(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; YAML
(use-package yaml-mode
  :mode (("\\.yaml\\'" . yaml-mode)
         ("\\.yml\\'" . yaml-mode)))

;; compilation
(setq compilation-read-command nil)
(global-set-key "\C-x\C-m" 'recompile)

;;; Backups
(defvar backup-directory "~/.emacs-backups")
(if (not (file-exists-p backup-directory))
    (make-directory backup-directory t))
(setq
 make-backup-files t        ; backup a file the first time it is saved
 backup-directory-alist `((".*" . ,backup-directory)) ; save backup files in configured directory
 backup-by-copying t     ; copy the current file into backup directory
 version-control t   ; version numbers for backup files
 delete-old-versions t   ; delete unnecessary versions
 auto-save-default t ; auto-save every buffer that visits a file
 )

;;; Graphics

;; display line numbers
(use-package nlinum
  :config
  (global-nlinum-mode t)
  (setq nlinum-format "%4d ")
  (setq nlinum-highlight-current-line t)
  (setq nlinum-delay t))

;; highlight numbers
(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))

;; better mode-line
(use-package smart-mode-line
  :config
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  (sml/setup))

;; theme
(if (display-graphic-p)
    (use-package dracula-theme
      :config (load-theme 'dracula t)))

;; remove unwanted bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; remove startup screen
(setq inhibit-splash-screen t)

;; disable blinking cursor
(setq visible-cursor nil)
(blink-cursor-mode -1)

;; display whitespace
(use-package whitespace
  :config
  (setq whitespace-style '(face empty tabs tab-mark lines-tail trailing))
  (global-whitespace-mode t))

;; display triangle for tab
(setq
 whitespace-display-mappings
 '((tab-mark 9 [9654 9] [92 9])))

;; Automatically resize unfocused windows
(use-package golden-ratio
  :diminish golden-ratio-mode
  :init
  (golden-ratio-mode 1)
  (setq golden-ratio-auto-scale t))

;; display file size
(size-indication-mode t)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
;; taken from prelude-ui.el
(setq frame-title-format
      '("" invocation-name ": " (:eval (if (buffer-file-name)
                                           (abbreviate-file-name (buffer-file-name))
                                         "%b"))))

;; update term title with frame-title
(defun xterm-title-update ()
  (interactive)
  (send-string-to-terminal (concat "\033]1; emacs " (buffer-name) "\007"))
  (if buffer-file-name
      (send-string-to-terminal (concat "\033]2; emacs " (buffer-file-name) "\007"))
    (send-string-to-terminal (concat "\033]2; emacs " (buffer-name) "\007"))))

(if (not window-system)
    (add-hook 'post-command-hook 'xterm-title-update))

;; smooth scrolling
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;;; init.el ends here
