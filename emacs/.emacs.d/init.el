(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("cbd8e65d2452dfaed789f79c92d230aa8bdf413601b261dbb1291fb88605110c" "e1498b2416922aa561076edc5c9b0ad7b34d8ff849f335c13364c8f4276904f0" "ed36f8e30f02520ec09be9d74fe2a49f99ce85a3dfdb3a182ccd5f182909f3ab" default))
 '(org-agenda-files '("~/School/school.org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(setq package-enable-at-startup nil)

(setq package-archives '(("ELPA"  . "http://tromey.com/elpa/")
			     ("gnu"   . "http://elpa.gnu.org/packages/")
			     ("melpa" . "https://melpa.org/packages/")
			     ("org" . "https://orgmode.org/elpa/")))
(package-initialize)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq package-enable-at-startup nil)
(straight-use-package 'use-package)
(require 'use-package)
(setq straight-use-package-by-default t)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq warning-minimum-level :emergency)
(setq confirm-kill-processes nil)
(setq ring-bell-function 'ignore)

(let ((custom-font "Droid Sans Mono-")
	  (font-size (cond ((= 1366 (display-pixel-width)) "11")
					   ((= 1920 (display-pixel-width)) "13")
					   (t "12"))))
  (let ((font-name (concat custom-font font-size)))
	(add-to-list 'default-frame-alist (cons 'font font-name))
	(set-face-attribute 'default t :font font-name)
	(set-face-attribute 'default nil :font font-name)
	(set-frame-font font-name nil t)))

(setq initial-startup-screen nil)
(setq initial-scratch-message ";; hiya answer owo")

(use-package kaolin-themes
  :config
  (setq kaolin-ocean-alt-bg t)
  (load-theme 'kaolin-ocean t))

(use-package colorless-themes
  :disabled
  :config (colorless-themes-load-theme nordless))

;; (load-theme 'whiteboard t)

;; (load-theme 'leuven t)

(use-package projectile
  :bind (:map projectile-mode-map
			  ("C-c p g" . projectile-grep))
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-i-jump nil)
  (setq evil-search-module 'evil-search)
  :config
  (evil-mode 1))

(use-package evil-collection
  :init
  (setq evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init))

(column-number-mode 1)

(use-package yasnippet
  :defer
  :hook ((latex-mode org-mode prog-mode) . yas-minor-mode))

(use-package yasnippet-snippets
	:after (yasnippet))

(use-package beacon
	:config (beacon-mode t))

(delete-selection-mode +1)

;; tabs
(setq-default indent-tabs-mode 'only)
(setq-default tab-width 4)
(defvaralias 'c-basic-offser 'tab-width)

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

(use-package selectrum
  :config (selectrum-mode 1))
(use-package selectrum-prescient
  :config
  (selectrum-prescient-mode +1)
  (prescient-persist-mode +1))
(use-package orderless
  :config
  (setq completion-styles '(orderless))
  (setq orderless-skip-highlighting (lambda () selectrum-is-active))
  (setq selectrum-highlight-candidates-function #'orderless-highlight-matches))
(use-package mini-frame
  :disabled
  :config (mini-frame-mode +1))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(use-package rainbow-delimiters
  :defer t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package doom-modeline
  :config
  (setq doom-modeline-icon (display-graphic-p))
  (doom-modeline-mode 1))

(use-package company
  :hook (prog-mode . company-mode)
  :defer t
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  (company-backends '(company-capf))
  (company-selection-wrap-around t))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package smartparens
  :defer t
  :hook (prog-mode . smartparens-mode)
  :config (require 'smartparens-config))

(use-package evil-smartparens
  :defer t
  :config (add-hook 'smartparens-enabled-hook #'evil-smart-parens-mode))

(use-package lsp-mode
  :defer t
  :config (setq lsp-enable-on-type-formatting nil))

(use-package flycheck
  :defer t
  :hook (prog-mode . flycheck-mode))

(add-hook 'c-mode-common-hook #'lsp)

;; org-mode
(setq org-adapt-indentation nil)

(add-hook 'org-mode-hook #'org-indent-mode)

(use-package org-plus-contrib)

(use-package page-break-lines)
(use-package dashboard
  :custom
  (dashboard-items '((agenda . 10)
					 (recents . 5)
					 (projects . 5)))
  :config
  (setq inhibit-start-message t)
  (dashboard-setup-startup-hook))


;; (use-package dtrt-indent)
;; (add-hook 'prog-mode-hook #'dtrt-indent-mode)
(use-package dumb-jump
  :config (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package simple-httpd
  :config (httpd-start))
(use-package impatient-mode
  :after (simple-httpd))

(defun answer-config/impatient-in-the-browser ()
  (interactive)
  (browse-url (format "http://localhost:8080/imp/live/%s/" (current-buffer))))

(use-package web-mode
  :mode ("\\.phtml\\'" "\\.tpl\\.php\\'" "\\.jsp\\'" "\\.as[cp]x\\'"
		 "\\.erb\\'" "\\.mustache\\'" "\\.djhtml\\'" "\\.jst.ejs\\'"
		 "\\.html?\\'")
  :hook (web-mode . lsp)
  :config
  (add-hook 'web-mode-hook '(lambda () (impatient-mode t)))
  :bind (("<f5>" . answer-config/impatient-in-the-browser)))

(use-package emmet-mode
  :after (web-mode)
  :bind (:map emmet-mode-keymap
			  ("<backtab>" . emmet-expand-line))
  :hook (sqml-mode web-mode css-mode))

(add-hook 'prog-mode-hook 'hl-line-mode)

(setq lsp-clients-typescript-log-verbosity "log")
(add-hook 'js-mode-hook #'lsp)
(require 'cl)
(with-eval-after-load 'lsp-clients
  (cl-nsubst '(nconc (list "/usr/local/bin/node" "--unhandled-rejections=strict" (lsp-package-path 'typescript-language-server)) (cons "--tsserver-path" (cons (lsp-package-path 'typescript) lsp-clients-typescript-server-args)))
			 '(cons (lsp-package-path 'typescript-language-server) (cons "--tsserver-path" (cons (lsp-package-path 'typescript) lsp-clients-typescript-server-args)))
			 (lsp--client-new-connection (gethash 'ts-ls lsp-clients))
			 :test 'equal))

(use-package shell-pop
	:config
	;; fixes a bug where frames will swap randomly
	(push (cons "\\*shell\\*" display-buffer--same-window-action) display-buffer-alist)
	:bind (("C-`" . shell-pop)))

 (use-package magit
	:bind (("C-x g" . magit-status)))

(use-package nim-mode
  :hook (nim-mode . nimsuggest-mode))
(add-hook 'nim-mode-hook 'lsp)
(add-hook 'nim-mode-hook
		  (lambda () (run-hooks 'prog-mode-hook)))
(setq exec-path (append exec-path '("/home/cherry/.nimble/bin")))

;; gdb
(setq-default gdb-display-io-nopopup t)

;; java
(use-package lsp-java
  :hook (java-mode . lsp))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((java . t)))
(nconc org-babel-default-header-args:java
       '((:dir . nil)
         (:results . value)))
;; dart mode
(use-package dart-mode
  :custom
  (dart-format-on-save t))
(use-package lsp-dart
  :hook (dart-mode . lsp))
(use-package hover
  :bind (:map dart-mode-map
              ("C-M-z" . #'hover-run-or-hot-reload)
              ("C-M-x" . #'hover-run-or-hot-restart)
              ("C-M-p" . #'hover-take-screenshot))
  :init
  (setq hover-hot-reload-on-save t
		hover-clear-buffer-on-hot-restart t))
(setq exec-path (append exec-path '("/home/cherry/go/bin")))

(use-package bison-mode
  :straight (bison-mode :type git :host github :repo "Wilfred/bison-mode"))

(use-package lsp-python-ms
  :after (lsp)
  :hook (python-mode . lsp-deferred)
  :custom
  (lsp-python-auto-install-server t))

(use-package restclient)
(use-package ob-restclient
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((restclient . t))))
