;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;
(require 'compile)
(require 'go-mode)

(defun jz-exchange-args ()
  (interactive)
  (evil-visual-char)
  (call-interactively #'evil-inner-arg)
  (call-interactively #'evil-exchange))

(defun shell-mode-move-cursor-after-prompt ()
  (interactive)
  (if (evil-normal-state-p)
      (progn
        (call-interactively #'end-of-buffer)
        (evil-insert-state))
    (insert "i")))

(use-package! find-file-in-project
  :config
  (setq ffip-use-rust-fd t
        ffip-project-file '(".svn" ".hg" ".git" ".projectile"))
  (map! :map c-mode-map
          :localleader
          "o o" #'jz-toggle-cpp-h)
  (map! :map c++-mode-map
        :localleader
        "o o" #'jz-toggle-cpp-h)
  (map! :leader
        "p u" #'find-file-in-project))
(map! :leader
      "/ s" #'swiper-thing-at-point)
(map! :leader
      "i e" #'jz-eval-region-and-replace)
(use-package! helm
  :config
  (setq helm-buffer-max-length 56))

(use-package! eshell
  :config
  (prefer-coding-system 'utf-8))

(use-package! clang-format
  :config
  (map! :map c++-mode-map
        :localleader
        "f b" #'clang-format-buffer)
  (map! :map c-mode-map
        :localleader
        "f b" #'clang-format-buffer))

(map!
 (:map override
        "<f6>" #'(lambda () (interactive) (call-interactively #'+eshell/split-below))))
(map! (:map override
        "<f2><f2>" #'jz-insert-\;-at-end-of-line))
(map! (:map override
        "C-x r d" #'bookmark-delete))

(map! :gnvi  "C-f" #'forward-char
      :gnvi  "C-f" #'forward-char
      :gnvi  "C-b" #'backward-char
      :gnvi  "C-b" #'backward-char
      :gnvi  "C-k" #'previous-line
      :gnvi  "C-j" #'next-line
      :gnvi  "C-e" #'end-of-line
      :gnvi  "C-a" #'evil-beginning-of-line
      :gnvi  "C-x K" #'jz-kill-buffer-and-window
      :gnvi  "C-]" #'xref-find-definitions
      :gnvi  "C-g" #'jz-keybord-quit-and-switch-2-evil-normal-mode
      :nv   "g C-]" #'xref-find-definitions-other-window)
(map! :map ivy-minibuffer-map
      "<escape>" #'doom/escape)
(map! :map c++-mode-map
      :localleader
      "y y" #'cpp-short-func-to-long-func)
(map! :map c-mode-map
      :localleader
      "y y" #'cpp-short-func-to-long-func)

(map! (:map (shell-mode-map)
        "i" #'shell-mode-move-cursor-after-prompt))
(map! (:map (evil-visual-state-map)
        "v" #'er/expand-region
        "i b"#'evil-textobj-anyblock-a-block
        "V" #'+evil:defun-txtobj))

(map! (:map (evil-insert-state-map)
        "C-<ret>" #'evil-open-below
        "<escape>" #'evil-force-normal-state))


(map! :v  "@"     #'+evil:apply-macro
      :textobj
      "b" #'evil-textobj-anyblock-inner-block
      #'evil-textobj-anyblock-a-block)


(map! (:map ivy-minibuffer-map
        "C-j" #'ivy-next-line
        "C-k" #'ivy-previous-line))
(map! (:map helm-ag-map
        "C-j" #'helm-next-line
        "C-k" #'helm-previous-line))

(map! :map c++-mode-map
     :nv "ga" #'jz-exchange-args
     :gnvi "<tab>" #'jz-find-next-args
     :gnvi "C-i" #'jz-find-next-args
     :gnvi "<backtab>" #'jz-find-previous-args
     )

(map! :map c-mode-map
     :nv "ga" #'jz-exchange-args
     :gnvi "<tab>" #'jz-find-next-args
     :gnvi "C-i" #'jz-find-next-args
     :gnvi "<backtab>" #'jz-find-previous-args)
(map! :map override
      :leader
      "c y"   #'jz-comment-and-yank-down
      "s a"   #'jz-evil-surround-at-point
      "f z d" #'jz-open-current-file-of-folder
      "b K" #'jz-kill-buffer-and-window
      "s h" #'symbol-overlay-put
      "s C" #'symbol-overlay-remove-all
      "s s" #'helm-do-ag-this-file
      "s S" #'jz-helm-do-ag-this-file-at-point
      "s P" #'jz-helm-ag-project-root-at-point
      "s p" #'helm-do-ag-project-root)

(map! :map symbol-overlay-map
      "h" #'backward-char)
(defvar compilation-error-regexp-alist-alist
  `((absoft
     "^\\(?:[Ee]rror on \\|[Ww]arning on\\( \\)\\)?[Ll]ine[ \t]+\\([0-9]+\\)[ \t]+\
of[ \t]+\"?\\([a-zA-Z]?:?[^\":\n]+\\)\"?:" 3 2 nil (1))
    (guile-file "^In \\(.+\\..+\\):\n" 1 nil nil 0)
    (guile-line "^ *\\([0-9]+\\): *\\([0-9]+\\)" nil 1 2)
    (msbuild "^[ \t]*\\(.+\\)(\\([0-9]+\\)):[ ]*\\(warning\\|note\\|error\\)" 1 2)
    )
  "Alist of values for `compilation-error-regexp-alist'.")

(map! :gnvi
        "M-1" #'winum-select-window-1
        "M-2" #'winum-select-window-2
        "M-3" #'winum-select-window-3
        "M-4" #'winum-select-window-4
        "M-5" #'winum-select-window-5
        "M-6" #'winum-select-window-6
        "C-SPC" nil
        "C-@" nil)

(map! :map helm-ag-map
      :g "C-f" #'forward-char
      :g "C-b" #'backward-char)


(map! :map swiper-map
      "C-w" #'evil-delete-backward-word)

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)


(use-package! completion
  :config
  (map! :map company-mode-map
        :g "C-g" #'jz-keybord-quit-and-switch-2-evil-normal-mode
        :map company-active-map
        :g "C-g" #'jz-keybord-quit-and-switch-2-evil-normal-mode
        :g "<tab>" #'jz-find-next-args)
  (setq company-transformers nil))

(use-package! lsp
  :config
  (setq lsp-auto-guess-root nil)
  (setq company-transformers nil))


;;(use-package! lsp-ui
;;  :config
;;  (setq lsp--highlight-kind-face nil))



(use-package! wgrep
  :config
  (map! (:map helm-buffer-map
          "C-e" #'wgrep-change-to-wgrep-mode))
  )

(use-package! helm-xref
 :config
 (if (< emacs-major-version 27)
     (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
   (setq xref-show-xrefs-function 'helm-xref-show-xrefs-27)))

(defun jz-cpp-hook ()
  (make-local-variable 'company-transformers)
  (setq company-transformers nil))
(add-hook 'c++-mode-hook 'jz-cpp-hook)

(use-package! dired
  :config
  (put 'dired-find-alternate-file 'disabled nil)
  (map! :map dired-mode-map
        :gnv "RET" #'dired-find-alternate-file
        :gnv "^" #'(lambda ()
                     (interactive)
                     (set-buffer-modified-p nil)
                     (find-alternate-file ".."))))
 (setenv "GTAGSTHROUGH" "true")
  ;; (setenv "GTAGSLIBPATH"
  ;;         "d:/msys64/mingw64/x86_64-w64-mingw32/include;d:/msys64/mingw64/include/c++/8.2.0")
(if (eq system-type 'windows-nt)
    (progn
      (setenv "GOPATH" "C:/Users/lenovo/go")
      (setenv "PATH" "D:/msys64/mingw64/bin;D:/msys64/usr/bin;C:/Windows/System32;C:/Windows;$GOPATH/bin;D:/Program Files/LLVM\bin;D:/root/opt/python/3.7.2")))

(defun my-cpp-hook nil
  (setq company-transformers nil)
  (setq lsp--highlight-kind-face nil))
(add-hook 'c++-mode-hook 'my-cpp-hook)
(add-hook 'c-mode-hook 'my-cpp-hook)
(add-hook 'lsp-mode-hook 'my-cpp-hook)
(add-hook 'company-mode-hook 'my-cpp-hook)
(add-hook 'company-prescient-mode-hook 'my-cpp-hook)

(defun ibus-switch-to-pinyin ()
  (interactive)
  (start-process-shell-command "im-slect" "*im-select*" "ibus engine libpinyin"))

(defun ibus-switch-to-en ()
  (interactive)
  (start-process-shell-command "im-select" "*im-select*" "ibus engine xkb:us::eng"))

(add-hook 'evil-normal-state-entry-hook 'ibus-switch-to-en)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
