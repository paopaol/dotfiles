;;(require 'mmm-mode)

(defun current-char (pos)
  "return value of current cursor"
  (interactive)
  (buffer-substring-no-properties pos (+ pos 1)))


(defun find-right-pair (left right pos)
  "find the right brackets `)', if found, return the `)' of position"
  "else return -1 first found `(', it will find `)' one by one,"
  "until the (equal 1 (- right-bracket-number left-bracket-number))"
  (let ((right-number 0) (found nil))
    (save-excursion
      (while (and (not found) (< pos (point-max)) )
        (progn
          (cond
           ((equal left (current-char pos))
            (progn
              (setq right-number (- right-number 1) )))
           ((equal right (current-char pos))
            (progn
              (setq right-number (+ right-number 1) )
              (if (equal 1 right-number) (setq found t)))))
          (if (not found)
              (setq pos (+ pos 1)) )))
      (if found
          pos
        nil))))

(defun find-left-pair (left right pos)
  (let ((number 0) (found nil))
    (save-excursion
      ;; (if (equal ")" (current-char pos))
      ;;       (setq found t))
      (while (and (not found) (> pos (point-min) ))
        (progn
          (cond
           ((equal right (current-char pos))
            (progn
              (setq number (- number 1))))
           ((equal left (current-char pos))
            (progn
              (setq number (+ number 1))
              (if (equal 1 number)
                (setq found t)))))
          (if (not found)
            (setq pos (- pos 1)) )))
      (if found
        pos
        nil))))


;; (defun in-brackets-pair-p ()
;;   "test current cursor is in brackets pair or not"
;;   "if return non nil, is in brackets pair,else return nil"
;;   (interactive)
;;   (let* ((pos (point))
;;          (left-pos (or (find-left-pair "(" ")" pos) 1))
;;          (right-pos (find-right-pair "(" ")" (+ 1 left-pos ))))
;;     (if (and left-pos right-pos)
;;         (or (>= right-pos pos) nil))))
(defun in-brackets-pair-p ()
  "test current cursor is in brackets pair or not"
  "if return non nil, is in brackets pair,else return nil"
  (interactive)
  (let* ((pos (point))
         (left-big-pos (or (find-left-pair "{" "}" pos) 1))
         left-pos
         right-pos)
    (cond
     ((equal "(" (current-char pos))
      nil)
     ((equal ")" (current-char pos))
      (progn
        (setq right-pos pos)
        (setq left-pos (find-left-pair "(" ")" (- right-pos 1)))))
     (t
      (progn
        (setq left-pos (or (find-left-pair "(" ")" pos) 1))
        (setq right-pos (find-right-pair "(" ")" (+ 1 left-pos))))))
    (if (and left-pos right-pos (> left-pos left-big-pos))
        (or (>= right-pos pos) nil))))

(defun in-big-brackets-p ()
  (interactive)
  (let* ((pos (point))
         (right-pos (or (find-right-pair "{" "}" pos) 1))
         (left-pos (find-left-pair "{" "}" right-pos)))
    (and right-pos left-pos)))

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

(defun jz-insert-\;-at-end-of-line ()
  (interactive)
  (save-excursion
  (evil-end-of-line)
  (evil-insert-state)
  (forward-char 1)
  (insert ";")
  (evil-normal-state)))


(defun jz-eglot-completion ()
  (interactive )
  (company-abort)
  (call-interactively 'company-lsp)
  )

(defun jz-clang-format ()
  (interactive)
  (call-interactively 'clang-format-buffer))

(defun jz-lsp-start-workspace ()
  (interactive)
  (call-interactively 'lsp))

(defun jz-lsp-shutdown-workspace ()
  (interactive)
  (call-interactively 'lsp-shutdown-workspace))


(defun jz-win-0 ()
  (interactive)
  (treemacs-select-window))

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

(defun jz-helm-ag-preview-file ()
  (interactive)
  (let ((ag-win-num))
    (setq ag-win-num (winum-get-number))
    (helm-ag-mode-jump-other-window)
    (hl-line-mode)
    (winum-select-window-by-number ag-win-num)))



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


(defun cpp-short-func-to-long-func ()
  (interactive)
  (beginning-of-line)
  (search-forward "(" (line-end-position) nil nil)
  (backward-char)
  (backward-char)
  (lsp-hover)
  (sleep-for 0 200)
  (kill-new (concat "\n" lsp--eldoc-saved-message "\n{\n}\n")))


(defun jz-upper-camel-case ()
  (interactive)
  (if (use-region-p)
      (progn
        (let* ((selection (buffer-substring-no-properties (region-beginning) (region-end)))
            (camel (s-upper-camel-case selection)))
        (save-restriction
          (narrow-to-region (region-beginning) (region-end))
          (goto-char (point-min))
          (while (search-forward selection nil t)
            (replace-match camel)))))))

(defun move-cursor-to-window ($buffer-name)
  "switch cursour to a window, which this window now shown a buffer named $buffer-name"
  (dolist (num '(1 2 3 4 5 6 7 8 9))
    (winum-select-window-by-number num)
    (if (string= (buffer-name) $buffer-name)
        (return))))

(defun jz-google-translate-at-point ()
  (interactive)
  (call-interactively #'google-translate-at-point)
  (move-cursor-to-window "*Google Translate*"))
