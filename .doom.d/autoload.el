;;; ~/.doom.d/autoload.el -*- lexical-binding: t; -*-
;;(require 'mmm-mode)
;;

(require 'winum)

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
              (setq right-number (decf right-number) )))
           ((equal right (current-char pos))
            (progn
              (setq right-number (incf right-number) )
              (if (equal 1 right-number) (setq found t)))))
          (if (not found)
              (setq pos (incf pos)) )))
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
              (setq number (decf number))))
           ((equal left (current-char pos))
            (progn
              (setq number (incf number))
              (if (equal 1 number)
                (setq found t)))))
          (if (not found)
            (setq pos (decf pos)) )))
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
        (setq right-pos (find-right-pair "(" ")" (incf left-pos))))))
    (if (and left-pos right-pos (> left-pos left-big-pos))
        (or (>= right-pos pos) nil))))

(defun in-big-brackets-p ()
  (interactive)
  (let* ((pos (point))
         (right-pos (or (find-right-pair "{" "}" pos) 1))
         (left-pos (find-left-pair "{" "}" right-pos)))
    (and right-pos left-pos)))

;;;###autoload
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

;;;###autoload
(defun jz-keybord-quit-and-switch-2-evil-normal-mode ()
  (interactive)
  (save-excursion
    (company-abort)
    (evil-force-normal-state)))

;;;###autoload
(defun jz-insert-\;-at-end-of-line ()
  (interactive)
  (save-excursion
    (evil-end-of-line)
    (evil-insert-state)
    (forward-char 1)
    (insert ";")
    (evil-force-normal-state)
    (company-abort)))


(defun jz-eglot-completion ()
  (interactive )
  (company-abort)
  (call-interactively 'company-lsp)
  )

(defun jz-clang-format ()
  (interactive)
  (call-interactively 'clang-format-buffer))

;;;###autoload
(defun jz-lsp-start-workspace ()
  (interactive)
  (lsp-mode 0)
  (lsp! t))

;;;###autoload
(defun jz-lsp-shutdown-workspace ()
  (interactive)
  (call-interactively 'lsp-shutdown-workspace))

;;;###autoload
(defun jz-lsp-restart-workspace ()
  (interactive)
  (jz-lsp-shutdown-workspace)
  (jz-lsp-start-workspace))


(defun jz-win-0 ()
  (interactive)
  (treemacs-select-window)
  (treemacs-mode))

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

;;;###autoload
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



;;;###autoload
(defun jz-comment-and-yank-down ()
  (interactive)
  (let ((end-line))
    (if (use-region-p)
        (setq end-line (jz-end-region-line-number))
        (setq end-line (+ 1 (line-number-at-pos))))
    (message (number-to-string end-line))
    (require 'evil-commentary)
    (call-interactively 'evil-commentary-yank-line)
    (goto-line end-line)
    (yank)
    (previous-line)
    (evil-first-non-blank)))

;;;###autload
(defun jz-open-current-file-of-folder ()
  (interactive)
  (require 'compile)
  (require 'files-x)
  (let ((path (file-name-directory (buffer-file-name))))
    (setq path (replace-regexp-in-string "/" "\\\\" path))
    (start-process "open-folder" nil "explorer" path)))

(defun jz-open-200-jz ()
  (interactive)
  (start-process "open-folder" nil "explorer" (encode-coding-string "\\\\192.168.16.200\\中转文件1号定时清空\\jz" 'cp936)))

;;;###autoload
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
(defun c-common-mode-evil-jump-item ()
  (interactive)
  (if (evil-visual-state-p)
      (beginning-of-line)
        (search-forward "{" (line-end-position) nil nil)
        (evil-visual-state)
        (call-interactively 'evil-jump-item)))

;;;###autoload
(defun evil-select-small-block ()
  "select outer `xxx{block}'"
  (interactive)
    (if (evil-visual-state-p)
          (progn
            (backward-char)
            (beginning-of-line)
            (if (search-forward "{" (line-end-position) t nil)
                (progn
                  (evil-jump-item)
                  (evil-normal-state)
                  (evil-visual-line)
                  (evil-jump-item)
                  (goto-char (line-beginning-position)))
                (progn
                  (beginning-of-line)
                  (if (search-forward "}" (line-end-position) t nil)
                      (progn
                        (evil-jump-item)
                        (evil-normal-state)
                        (evil-visual-line)
                        (evil-jump-item)
                        (goto-char (line-beginning-position)))
                    (evil-select-big-block)))))))

;;;###autoload
(defun evil-select-big-block ()
  "select outer `xxx{block}'"
  (interactive)
  (call-interactively 'evil-a-curly)
  (evil-visual-line))

;;;###autoload
(defun jz-find-next-args ()
        (interactive)
        (if (in-brackets-pair-p)
          (progn
            (call-interactively 'evil-forward-arg)
            (evil-normal-state))
          (search-forward "(" (line-end-position) nil nil)))
;;;###autoload
(defun jz-find-previous-args ()
        (interactive)
        (if (in-brackets-pair-p)
          (progn
            (evil-normal-state)
            (call-interactively 'evil-backward-arg))))

(defun jz-open-termianl-of-current-file ()
  (interactive)
  (let* ((current-file (buffer-file-name)))
    (if nil
        (start-process "powershell" nil "powershell" (concat "-NoExit " "-Command " current-file))
      (start-process "powershell" nil "powershell"))))

;;;###autoload
(defun jz-cmake-project-build ()
  "compile cmake project using cmake --build project-root-dir."
  (interactive)
  (let* ((cmd (concat "cmake --build " (projectile-project-root) "build")))
    (compile cmd)))

;;;###autoload
(defun jz-evil-replace ()
  "Replace text.in narrow buffer."
  (interactive )
  (let* ((key (if (not (evil-visual-state-p))
               (thing-at-point 'word)
               (buffer-substring
                (region-beginning) (region-end)))))
  (evil-ex (concat "%s/" key "/"))))

;;;###autoload
(defun jz-eval-region-and-replace (beg end)
  "Evaluation a region between BEG and END, and replace it with the result."
  (interactive "r")
      (kill-region beg end)
      (condition-case nil
          (prin1 (eval (read (current-kill 0)))
                (current-buffer))
        (error (message "Invalid expression")
              (insert (current-kill 0)))))

;;;###autoload
(defun jz-evil-surround-at-point (char)
  (interactive "c")
  (unless (use-region-p)
    (let (beg end)
      (save-excursion
        (backward-word)
        (setq beg (point)))
      (save-excursion
        (forward-word)
        (setq end (point)))
      (evil-surround-region beg end 'block char nil))))

;;;###autoload
(defun jz-kill-buffer-and-window ()
  (interactive)
  (kill-current-buffer)
  (evil-quit))

;;;###autoload
(defun helm-ag-find-next (&optional n)
  (interactive)
  (let* ((helm-current-buffer (get-buffer "*helm-ag*")))
    (with-helm-current-buffer
      (forward-line (or n 1))
      (helm-ag--action-find-file
       (buffer-substring-no-properties (point-at-bol) (point-at-eol))))))

;;;###autoload
(defun helm-ag-find-prev ()
  (interactive)
  (helm-ag-find-next -1))



;;;###autoload
(defun vterm--rename-buffer-as-title (title)
  (interactive)
  (rename-buffer (format "vterm %s" title) t))

;;;###autoload
(defun jz-vterm-right (title)
  (interactive "sTitle:")
  (evil-window-vsplit)
  (evil-window-right 1)
  (evil-window-set-height 10)
  (vterm)
  (vterm--rename-buffer-as-title title))


;;;###autoload
(defun jz-vterm-down (title)
  (interactive "sTitle:")
  (let* ((current-window-number winum--window-count))
    (evil-window-split)
    (evil-window-down 1)
    (if (eql 1 current-window-number)
        (evil-window-set-height 14)))
  (vterm)
  (vterm--rename-buffer-as-title title))

;;;###autoload
(defun jz-helm-do-ag-this-file-at-point ()
  (interactive)
  (if (not (use-region-p))
      (er/mark-symbol))
  (helm-do-ag-this-file))


;;;###autoload
(defun jz-helm-ag-project-root-at-point ()
  (interactive)
  (if (not (use-region-p))
      (er/mark-symbol))
  (helm-ag-project-root))
(modify-syntax-entry ?_ "w")
