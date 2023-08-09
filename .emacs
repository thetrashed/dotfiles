;; Some basic settings
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(show-paren-mode 1)

(setq inhibit-startup-screen t)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(global-hl-line-mode t) (column-number-mode 1)

;; Don't auto-save and back up files
(setq auto-save-default nil make-backup-files nil)

;; Set ido mode
(ido-mode 1)

;; Fonts
(set-frame-font "Source Code Pro 13" nil t)

;; Encoding
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; Packages
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(setq package-user-dir "~/.emacs.d/elpa")
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(unless (package-installed-p 'quelpa-use-package)
  (package-install 'quelpa-use-package))
(require 'quelpa-use-package)
(eval-and-compile
  (require 'use-package)
  (require 'bind-key)
  (setq use-package-always-ensure t
	use-package-expand-minimally t))

;; (use-package autothemer)
(use-package gruber-darker-theme)
;; (use-package rose-pine
;;  :quelpa (rose-pine :fetcher git :url "https://github.com/thongpv87/rose-pine-emacs.git"))

;; Theme
(load-theme 'gruber-darker 'no-confirm)

;; smex
(use-package smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Evil mode
(use-package evil)
(evil-mode 1)
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(package-selected-packages
   '(org-fragtog org-contrib quelpa-use-package org-bullets format-all clang-format lsp-jedi lsp-ui lsp-mode company gruber-darker-theme evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; LSP config
(use-package lsp-mode
  :after company
  :hook ((c-mode
	  c++-mode
	  python-mode
	  js-mode
	  web-mode
	  rust-mode) . lsp-derfered)
  :commands lsp
  :config
  (setq lsp-restart 'auto-restart)
  (setq lsp-completion-enable t)
  (setq lsp-auto-guess-root t)
  (setq lsp-eldoc-render-all t)
  (setq lsp-log-io nil)
  (setq lsp-enable-symbol-highlighting t)
  (setq lsp-enable-folding nil)
  (setq lsp-eldoc-enable-hover))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t))

(use-package lsp-jedi
  :hook (python-mode . (lambda () (require 'lsp-jedi)))
  :init (when (executable-find "python")
	  (setq lsp-jedi-python-executable-cmd "python")))


(use-package clang-format)

(use-package company
  :after lsp-mode
  :defer 2
  :hook (prog-mode . company-mode)
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay nil)
  (company-show-numbers t)
  (company-tooltip-align-annotations t)
  (company-frontends
   '(company-pseudo-tooltip-unless-just-one-frontend-with-delay
     company-preview-frontend
     company-echo-metadata-frontend))
  (global-company-mode t))

(global-set-key (kbd "M-p")
                (lambda ()
                  (interactive)
                  (let ((company-tooltip-idle-delay 0.0))
                    (company-complete)
                    (and company-candidates
			 (company-call-frontends 'post-command)))))

;; Compile options
(add-hook 'python-mode-hook
	  (lambda ()
	    (set (make-local-variable 'compile-command)
		 (concat "python " buffer-file-name))))

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
  (global-set-key (kbd "M-F") #'ian/format-code)
  (add-hook 'prog-mode-hook #'format-all-ensure-formatter))

;; Org-mode
(use-package org
  :pin gnu
  :init
  (setq org-use-speed-commands t
        org-return-follows-link t
        org-hide-emphasis-markers t
        org-completion-use-ido t
	org-return-follows-link t
        org-outline-path-complete-in-steps nil
        org-src-fontify-natively t   ;; Pretty code blocks
        org-src-tab-acts-natively t
        org-confirm-babel-evaluate nil
	org-enforce-todo-dependencies t
        org-todo-keywords '((sequence "TODO(t)" "DOING(g)" "|" "DONE(d)")
                            (sequence "|" "CANCELED(c)")))
  :config
  (setq org-agenda-files '("~/Wiki/src/tasks.org"))
  (setq org-log-done 'time)
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'visual-line-mode)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.75)))

(use-package org-bullets)
(use-package org-fragtog)

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
(add-hook 'org-mode-hook 'org-bullets-mode)
(add-hook 'org-mode-hook 'org-fragtog-mode)

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
;; Keybinds, org-mode
(define-key global-map "\C-ca" 'org-agenda)
(define-key org-mode-map (kbd "C-c <up>") 'org-priority-up)
(define-key org-mode-map (kbd "C-c <down>") 'org-priority-down)

(define-key org-mode-map (kbd "C-c C-l") (lambda ()
					   (interactive)
					   (org-mark-subtree)
					   (let ((limit (point)))
					     (save-excursion
					       (exchange-point-and-mark)
					       (while (> (point) limit)
						 (org-todo "DONE")
						 (outline-previous-visible-heading 1))
					       (org-todo "DONE")))))
(global-set-key (kbd "C-c C-w") (lambda ()
				  (interactive)
				  (find-file "~/Wiki/src/index.org")))

(define-key global-map (kbd "C-c C-j") 'split-window-below)
