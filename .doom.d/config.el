;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here


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

(map! (:map override
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
      :gnvi  "C-a" #'beginning-of-line)
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
