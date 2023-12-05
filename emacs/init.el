;; 1Based on the configuration file from https://github.com/MiniApollo/kickstart.emacs
(require 'server)
(unless (server-running-p)
  (server-start))

(setq inhibit-startup-messge t)
(setq inhibit-startup-screen t)
(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-indent-mode -1)    ;; Turn off the weird indenting that Emacs does by default.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
(show-paren-mode 1)

(global-auto-revert-mode t)  ;; Automatically reload file and show changes if the file has changed
(global-display-line-numbers-mode 1) ;; Display line numbers
(setq display-line-numbers-type 'relative)
(global-hl-line-mode t)

(global-visual-line-mode t)  ;; Enable truncated lines
(column-number-mode 1)
(menu-bar-mode -1)           ;; Disable the menu bar
(scroll-bar-mode -1)         ;; Disable the scroll bar
(tool-bar-mode -1)           ;; Disable the tool bar
(setq doc-view-continuous 1) ;; C-p and C-n scroll to new page in pdfs

(setq mouse-wheel-progressive-speed nil) ;; Disable progressive speed when scrolling
(setq scroll-conservatively 10) ;; Smooth scrolling when going down with scroll margin
(setq scroll-margin 8)

(setq auto-save-default nil
      make-backup-files nil) ; Stop creating ~ backup files

;; Move customization variables to a separate file and load it, avoid filling up init.el with unnecessary variables
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
(setq ring-bell-function 'ignore)

(global-set-key [escape] 'keyboard-escape-quit) ;; Makes Escape quit prompts (Minibuffer Escape)
(blink-cursor-mode 0) ;; Don't blink cursor
(add-hook 'prog-mode-hook (lambda () (hs-minor-mode t))) ;; Enable folding hide/show globally

(setq org-edit-src-content-indentation 4) ;; Set src block automatic indent to 4 instead of 2.
(setq-default tab-width 4)

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun efs/org-babel-tangle-config ()
  "Automatically tangle our Emacs.org config file when we save it. Credit to Emacs From Scratch for this one!"
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(require 'package)
(require 'use-package) ;; requires package.el and use-package so we can use it
(setq use-package-always-ensure t) ;; always ensures that a package is installed
(setq package-archives '(("melpa" . "https://melpa.org/packages/") ;; Sets default package repositories
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/"))) ;; For Eat Terminal

;; Theme
(use-package autothemer)
(add-to-list 'custom-theme-load-path "~/.config/emacs/themes")
(load-theme 'oxcarb 'no-confirm)

(ido-mode 1)

(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90)) ; For all new frames henceforth
(setq default-frame-alist '((font . "Source Code Pro 13")))


;; Encoding
(set-language-environment "utf-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(use-package projectile
  :config
  (projectile-mode 1)
  :init
  (setq projectile-switch-project-action #'projectile-dired)
  (setq projectile-project-search-path '("~/Programming/" "~/Wiki/"))) ;; . 1 means only search first subdirectory level for projects

;; Formatter
(use-package format-all
  :preface
  (defun ian/format-code ()
    "Auto-format whole buffer."
    (interactive)
    (if (derived-mode-p 'prolog-mode)
        (prolog-indent-buffer)
      (format-all-buffer)))
  :config
  (global-set-key (kbd "C-<tab>") #'ian/format-code)
  (add-hook 'prog-mode-hook #'format-all-ensure-formatter))

(use-package rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Modes
(use-package zig-mode
  :config
  (setq zig-format-on-save ()))

;; Python
(use-package python-mode)
(use-package auto-virtualenv
  :ensure t
  :init
  (use-package pyvenv
    :ensure t)
  :config
  (add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
  (add-hook 'projectile-after-switch-project-hook 'auto-virtualenv-set-virtualenv)  ;; If using projectile
  )

(add-hook 'python-mode-hook
		  (lambda ()
			(set (make-local-variable 'compile-command)
				 (concat "python " buffer-file-name))))

(use-package cc-mode)
(use-package lua-mode)

;; Treesitter
(use-package tree-sitter)
(use-package tree-sitter-langs)

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs '(zig-mode . ("zls")))
  (add-to-list 'eglot-server-programs '(python-mode . ("jedi-language-server")))
  (add-to-list 'eglot-server-programs '(c-mode . ("clangd")))
  (add-to-list 'eglot-server-programs '(c++-mode . ("clangd")))
  (add-to-list 'eglot-server-programs '(LaTeX-mode . ("digestif")))
  (setq eglot-autoshutdown t)
  :hook
  ((latex-mode . eglot-ensure))
  ((c-mode . eglot-ensure))
  ((c++-mode . eglot-ensure))
  ((python-mode . eglot-ensure))
  ((zig-mode . eglot-ensure)))

(use-package yasnippet-snippets
  :hook (prog-mode . yas-minor-mode))

(add-hook 'org-mode-hook 'org-indent-mode) ;; Indent text

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :after org)

(use-package darkroom
  :config
  (setq darkroom-text-scale-increase 0))

;; Org-mode
(with-eval-after-load 'org
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5)
		org-image-actual-width '(300)
		org-src-fontify-natively t
		org-hide-emphasis-markers t
		org-startup-with-latex-preview t
		org-use-sub-superscripts "{}"
		org-startup-with-inline-image t
		org-return-follows-link t)
  (require 'org-tempo))

(use-package org-fragtog)
(add-hook 'org-mode-hook 'org-fragtog-mode)

(use-package xenops)
(setq xenops-math-image-scale-factor 1.5)
(setq TeX-electric-sub-and-superscript t)
(add-hook 'LaTeX-mode-hook #'xenops-mode)
(add-hook 'latex-mode-hook #'xenops-mode)

(use-package eat
  :hook ('eshell-load-hook #'eat-eshell-mode))

(use-package magit
  :commands magit-status)

(use-package diff-hl
  :hook ((magit-pre-refresh-hook . diff-hl-magit-pre-refresh)
		 (magit-post-refresh-hook . diff-hl-magit-post-refresh))
  :init (global-diff-hl-mode))

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-auto-prefix 2)          ;; Minimum length of prefix for auto completion.
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

(use-package counsel
  :after ivy
  :diminish
  :config (counsel-mode))

(use-package ivy
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :diminish
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package diminish)

(use-package which-key
  :init
  (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
		which-key-sort-order #'which-key-key-order-alpha
		which-key-sort-uppercase-first nil
		which-key-add-column-padding 1
		which-key-max-display-columns nil
		which-key-min-display-lines 6
		which-key-side-window-slot -10
		which-key-side-window-max-height 0.25
		which-key-idle-delay 0.8
		which-key-max-description-length 25
		which-key-allow-imprecise-window-fit nil
		which-key-separator " → " ))

;; smex
(use-package smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
;; Increase the amount of data which Emacs reads from the process
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; Keybinds
(global-set-key (kbd "C-o") (lambda ()
							  (interactive)
							  (end-of-line)
							  (newline-and-indent)))
(global-set-key (kbd "M-o") (lambda ()
							  (interactive)
							  (previous-line)
							  (end-of-line)
							  (newline-and-indent)))

(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

  Move point to the first non-whitespace character on this line.
  If point was already at that position, move point to beginning of line."
  (interactive "^") ; Use (interactive) in Emacs 22 or older
  (let ((oldpos (point)))
	(back-to-indentation)
	(and (= oldpos (point))
		 (beginning-of-line))))

(global-set-key (kbd "C-a") 'smart-beginning-of-line)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(global-set-key (kbd "C-c h") (lambda ()
								(interactive)
								(load-file "~/.config/emacs/init.el")))

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-set-key (kbd "C-M-z") 'darkroom-tentative-mode)
