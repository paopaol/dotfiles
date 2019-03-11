
(defun jz-toggle-cpp-h ()
  (interactive)
  (setq filename (file-name-nondirectory (buffer-file-name)))
  (setq ext (file-name-extension filename))
  (if (string= ext "h")
      (progn
        (setq basename (concat (file-name-sans-extension filename) ".cpp"))
        (ffip-find-files basename nil)))
  (if (string= ext "cpp")
      (progn
        (setq basename (concat (file-name-sans-extension filename) ".h"))
        (ffip-find-files basename nil))))

(defun jz-keybord-quit-and-switch-2-evil-normal-mode ()
  (interactive)
  (evil-normal-state)
  (keyboard-quit))


(defun jz-eglot-completion ()
  (interactive )
  (company-abort)
  (call-interactively 'company-lsp)
  )

(defun jz-clang-format-buffer ()
  (interactive)
  (call-interactively 'clang-format-buffer))

(defun jz-lsp-start-workspace ()
  (interactive)
  (call-interactively 'lsp))

(defun jz-lsp-shutdown-workspace ()
  (interactive)
  (call-interactively 'lsp-shutdown-workspace))



(defun jz-win-1 ()
  (interactive)
  (winum-select-window-1))

(defun jz-win-2 ()
  (interactive)
  (winum-select-window-2))

(defun jz-win-3 ()
  (interactive)
  (winum-select-window-3))

(defun jz-win-4 ()
  (interactive)
  (winum-select-window-4))

(defun jz-win-5 ()
  (interactive)
  (winum-select-window-5))

(defun jz-start-region-line-number ()
  (line-number-at-pos (region-beginning)))

(defun jz-end-region-line-number ()
  (line-number-at-pos (region-end)))

(defun jz-comment ()
  (interactive)
  (if (use-region-p)
      (call-interactively 'evil-commentary)
    (call-interactively 'evil-commentary-line)))



(defun jz-comment-and-yank-down ()
  (interactive)
  (let ((end-line))
    (if (use-region-p)
        (setq end-line (jz-end-region-line-number))
        (setq end-line (+ 1 (line-number-at-pos))))
    (message (number-to-string end-line))
    (call-interactively 'evil-commentary-yank-line)
    (goto-line end-line)
    (yank)
    (previous-line)
    (evil-first-non-blank)))


(defun jz-open-current-file-of-folder ()
  (interactive)
  (let ((path (file-name-directory (buffer-file-name))))
    (setq path (replace-regexp-in-string "/" "\\\\" path))
    (start-process "open-folder" nil "explorer" path)))

(defun jz-open-200-jz ()
  (interactive)
  (start-process "open-folder" nil "explorer" (encode-coding-string "\\\\192.168.16.200\\中转文件1号定时清空\\jz" 'cp936)))
