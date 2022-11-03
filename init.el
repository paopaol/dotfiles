(setq package-archives '(("gnu"   . "http://1.15.88.122/gnu/")
                         ("melpa" . "http://1.15.88.122/melpa/")))
(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

(menu-bar-mode -1)
(tool-bar-mode -1)
(global-eldoc-mode -1)
(electric-pair-mode 1)
(setq make-backup-files nil)
(setq inhibit-startup-screen t)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(defun append-\;-end-of-line ()
  (interactive)
  (save-excursion
    (if (string= "insert" evil-state)
	(progn
	  (evil-append-line 1)
	  (insert";"))
      (progn
	(evil-append-line 1)
	(insert";")
	(evil-normal-state)))))

(defun jz-insert-\;-at-end-of-line ()
  (interactive)
  (save-excursion
    (evil-end-of-line)
    (evil-insert-state)
    (forward-char 1)
    (insert ";")
    (evil-force-normal-state)
    (company-abort)))






(require 'delsel)
(use-package vertico
  :init (vertico-mode)
  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)
  ;; Show more candidates
  ;; (setq vertico-count 20)
  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)
  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  :bind (:map vertico-map ("C-w" . evil-delete-backward-word)
	      ("<escape>" . minibuffer-keyboard-quit)
	      ("C-j" . vertico-next)
	      ("C-k" . vertico-previous)))

(defun evil-corfu-quit ()
  (interactive)
  (corfu-quit)
  (evil-normal-state))


(use-package corfu
  :ensure t
  ;; Optional customizations
  :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-auto-delay 0)
  (corfu-auto-prefix 0)
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-echo-documentation nil) ;; Disable documentation in the echo area
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin
  :bind (:map corfu-map
	      ("C-j" . corfu-next)
	      ("C-k" . corfu-previous))
  ;; Enable Corfu only for certain modes.
  :hook ((prog-mode . corfu-mode)
	 (shell-mode . corfu-mode)
	 (eshell-mode . corfu-mode))
  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-excluded-modes'.
  :init
  (global-corfu-mode))


;; Optionally use the `orderless' completion style.

(use-package orderless
  :ensure t
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

;; Example configuration for Consult
(use-package consult
  :ensure t
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window

         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame

         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)

         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)

         ("M-g k" . consult-global-mark)

         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)
  ;; The :init configuration is always executed (Not lazy)
  :init
  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config
  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))
  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")
  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)
  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
  )

(use-package dabbrev
  :ensure t
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand))
  ;; Other useful Dabbrev configurations.
  :custom
  (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'")))

;; (quelpa '(popon :fetcher git
;;                 :url "https://codeberg.org/akib/emacs-popon.git"))
;;
;; (quelpa '(corfu-terminal
;;           :fetcher git
;;           :url "https://codeberg.org/akib/emacs-corfu-terminal.git"))

(unless (display-graphic-p)
  (corfu-terminal-mode +1))

(use-package savehist
  :init
  (savehist-mode))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(use-package vterm
  :ensure t)

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  )

(use-package cmake-mode
  :ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-terminal-cursor-changer
  :ensure t
  :init
  (unless (display-graphic-p)
    (require 'evil-terminal-cursor-changer)
    (evil-terminal-cursor-changer-activate) ; or (etcc-on)
    )
  (setq evil-motion-state-cursor 'box)  ; █
  (setq evil-visual-state-cursor 'box)  ; █
  (setq evil-normal-state-cursor 'box)  ; █
  (setq evil-insert-state-cursor 'bar)  ; ⎸
  (setq evil-emacs-state-cursor  'hbar) ; _
  )

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-nerd-commenter
  :ensure t
  :bind (
	 :map evil-normal-state-map
	 ("gcc" . evilnc-comment-or-uncomment-lines)
	 ("gy" . evilnc-copy-and-comment-lines)
	 :map evil-visual-state-map
	 ("gc" . evilnc-comment-or-uncomment-lines)
	 ("gy" . evilnc-copy-and-comment-lines)))

(require 'xref)
(use-package evil-collection
  :after evil
  :ensure t
  :bind (
	 :map special-event-map
	 ("q" . quit-window)
	 :map global-map
	 ("<f2><f2>" . append-\;-end-of-line)
	 ("<f1>" . treemacs)
	 ("C-u" . evil-scroll-up)
	 ("C-j" . next-line)
	 ("C-k" . previous-line)
	 ("M-j" . evil-window-down)
	 ("M-k" . evil-window-up)
	 ("M-l" . evil-window-right)
	 ("M-h" . evil-window-left)
	 :map evil-normal-state-map
	 ("gr" . xref-find-references)
	 ("gf" . eglot-code-actions)
	 :map evil-insert-state-map
	 ("<escape>" . evil-corfu-quit)
	 ("C-j" . next-line)
	 ("C-e" . evil-append-line)
	 ("C-a" . beginning-of-line)
	 ("C-k" . previous-line)
	 :map evil-motion-state-map
	 ("C-e" . evil-append-line))
  :config
  (evil-collection-init))


(use-package  which-key
  :ensure t
  :config (which-key-setup-minibuffer)
  :init (which-key-mode))

(use-package general
  :ensure t)

(use-package restart-emacs
  :ensure t)

(use-package format-all
  :ensure t)

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet
  :init
  (yas-global-mode 1))


(use-package color-theme-sanityinc-tomorrow
  :ensure t)

(use-package doom-modeline
  :ensure t
  :config
  (doom-modeline-def-modeline 'my-simple-line
    '(matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes input-method buffer-encoding major-mode process vcs checker))
  :hook (after-init . doom-modeline-mode))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-dracula t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;;(doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;;(doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "

          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   t
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc

          treemacs-select-when-already-in-treemacs 'move-back

          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil

          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t

          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)
	:map treemacs-mode-map
	("M-l" . evil-window-right)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'prog-mode-hook  'rainbow-delimiters-mode))

(use-package symbol-overlay
  :ensure t
  :bind (:map symbol-overlay-map
	      ("h" . evil-backward-char) ))



(general-create-definer jz-def
  :states '(normal insert emacs)
  :prefix "SPC"
  :non-normal-prefix "M-SPC"
  :prefix-command 'tyrant-prefix-command
  :prefix-map 'tyrant-prefix-map)

(jz-def
  "t" '(:wk "tool")
  "tp" '(package-list-packages :wk "theme")
  "tc" '(consult-theme :wk "theme"))

(jz-def
  "f" '(:wk "file")
  "ff" '(projectile-find-file :wk "project files")
  "fd" '(projectile-find-file-in-directory :wk "directory files")
  "fp" '(projectile-find-file :wk "project files")
  "fr" '(recentf :wk "recent files"))

(jz-def
  "w" '(:wk "window")
  "w1" '(delete-other-windows :wk "window other close")
  "ws" '(evil-window-split :wk "window split")
  "wv" '(evil-window-vsplit :wk "window vsplit")
  "wd" '(delete-window :wk "window close"))

(jz-def
  "i" '(:wk "insert")
  "is" '(yas/insert-snippet :wk "insert snippet"))

(jz-def
  "b" '(:wk "buffer")
  "bk" '(evil-delete-buffer :wk "buffer close")
  "bb" '(consult-buffer :wk "list buffers"))

(jz-def
  "s" '(:wk "search/symbol")
  "si" '(consult-imenu :wk "imenu")
  "sh" '(symbol-overlay-put :wk "highlight symbol")
  "sC" '(symbol-overlay-remove-all :wk "remove all highlight")
  "ss" '(consult-line :wk "search line")
  "sp" '(consult-ripgrep :wk "ripgrep"))

(general-create-definer jz-local-leader-def
  ;; :prefix jz-local-leader
  :prefix ",")


(require 'eglot)

;;;###autoload
(defun eglot-clangd-switch-source-header ()
  "Try to toggle between source file and header file."
  (interactive)
  (let ((buf (current-buffer)))
    (jsonrpc-async-request (eglot--current-server-or-lose)
                           :textDocument/switchSourceHeader (eglot--TextDocumentIdentifier)
                           :success-fn (lambda (file-uri)
                                         (unless (string-blank-p file-uri)
                                           (find-file (eglot--uri-to-path file-uri)))))))



(jz-local-leader-def 'normal c++-mode-map
  "," 'eglot-format-buffer
  "o" 'eglot-clangd-switch-source-header)


(jz-local-leader-def 'normal emacs-lisp-mode-map
  "," 'format-all-buffer
  "o" 'eglot-clangd-switch-source-header)

(jz-local-leader-def 'visual c++-mode-map
  "," 'format-all-region)


(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'cmake-mode-hook 'eglot-ensure)

(require 'eglot)
(add-to-list 'eglot-server-programs
	     `(c++-mode . ("clangd" "--clang-tidy" "-j=1" "--header-insertion=never"
			   "--compile-commands-dir=build" "--completion-style=detailed")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(corfu-terminal popon which-key vertico use-package smooth-scrolling restart-emacs quelpa orderless general format-all evil-collection elisp-format corfu color-theme-sanityinc-tomorrow)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
