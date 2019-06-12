(require 'shell)
(global-set-key (kbd "C-<tab>") 'jz-eglot-completion)
(global-set-key (kbd "C-j") 'next-line)
(global-set-key (kbd "C-k") 'previous-line)
;; (global-set-key (kbd "C-g") 'jz-keybord-quit-and-switch-2-evil-normal-mode)
(global-set-key (kbd "C-s") 'evil-normal-state)
(global-set-key (kbd "C-x r d") 'bookmark-delete)
(global-set-key (kbd "C-x r l") 'helm-bookmarks)
(global-set-key (kbd "<f2> <f2>") 'jz-insert-\;-at-end-of-line)
(show-paren-mode 1)


;; Show the current function name in the header line                                (which-function-mode)
;; 调整which-function在mode-line中的显示格式：
;; M-x list-faces-display 找到which-function，然后点击后面的样式，点击进去后调整，保存即可
(which-function-mode)
(setq-default header-line-format
              '((which-func-mode ("" which-func-format " "))))
(setq mode-line-misc-info
      ;; We remove Which Function Mode from the mode line, because it's mostly
      ;; invisible here anyway.
      (assq-delete-all 'which-func-mode mode-line-misc-info))
(setq-default header-line-format
         '((which-func-mode ("" which-func-format " "))))

;; (modify-syntax-entry ?. "w" c++-mode-syntax-table)
;; (modify-syntax-entry ?. "w" c-mode-syntax-table)

(define-key shell-mode-map "i" '(lambda ()
                                (interactive)
                                (if (evil-normal-state-p)
                                  (progn
                                    (end-of-buffer)
                                    (evil-insert-state))
                                  (insert "i"))))
