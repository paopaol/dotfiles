;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(require 'compile)

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

(def-package! find-file-in-project
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

(def-package! eshell
  :config
  (prefer-coding-system 'gbk))

(def-package! clang-format
  :config
  (map! :map c++-mode-map
        :localleader
        "f b" #'clang-format-buffer)
  (map! :map c-mode-map
        :localleader
        "f b" #'clang-format-buffer))

(map!
 (:map override
        "<f6>" #'+eshell/split-below))
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
      :gnvi  "C-a" #'beginning-of-line
      :gnvi  "C-]" #'evil-goto-definition
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
        "v" #'evil-select-small-block
        "V" #'c-mark-function))

(map! (:map ivy-minibuffer-map
        "C-j" #'ivy-next-line
        "C-k" #'ivy-previous-line))

(map! :map c++-mode-map
     :nv "ga" #'jz-exchange-args
     :gnvi "<tab>" #'jz-find-next-args
     :gnvi "S-<tab>" #'jz-find-previous-args)
(map! :map c-mode-map
     :nv "ga" #'jz-exchange-args
     :gnvi "<tab>" #'jz-find-next-args
     :gnvi "S-<tab>" #'jz-find-previous-args)
(map! :map override
      :leader
      "c y"   #'jz-comment-and-yank-down
      "f z d" #'jz-open-current-file-of-folder)
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
        "C-1" #'winum-select-window-1
        "C-2" #'winum-select-window-2
        "C-3" #'winum-select-window-3
        "C-4" #'winum-select-window-4
        "C-5" #'winum-select-window-5
        "C-6" #'winum-select-window-6)

(map! :map helm-ag-map
      :g "C-f" #'forward-char
      :g "C-b" #'backward-char)
(map! :map company-active-map
      :g "C-g" #'jz-keybord-quit-and-switch-2-evil-normal-mode)

(def-package! wgrep
  :config
  (map! (:map helm-buffer-map
          "C-e" #'wgrep-change-to-wgrep-mode))
  )

(def-package! helm-xref
  :config
  (if (< emacs-major-version 27)
      (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
    (setq xref-show-xrefs-function 'helm-xref-show-xrefs-27)))
