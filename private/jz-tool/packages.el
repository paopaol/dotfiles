;;; packages.el --- jz-tool layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author:  <lenovo@LAPTOP-04CCA0HR>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `jz-tool-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `jz-tool/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `jz-tool/pre-init-PACKAGE' and/or
;;   `jz-tool/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst jz-tool-packages
  '(find-file-in-project
    window-number
    evil-commentary
    evil-surround
    evil-easymotion
    evil-fringe-mark
    evil-args
    rainbow-delimiters
    symbol-overlay
    expand-region
    google-translate
    leuven-theme
    wgrep-helm
    treemacs
    treemacs-evil
    treemacs-projectile
    format-all
    markdown-mode
    company
    keyfreq
    helm-gtags)
  "The list of Lisp packages required by the jz-tool layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


(defun jz-tool/init-find-file-in-project ()
  (use-package find-file-in-project
    ;; :defer t
    :config
    (require 'srecode)
    (add-hook 'c++-mode-hook #'semantic-mode)
    (add-hook 'c-mode-hook #'semantic-mode)
    (dolist (mode '(c++-mode c-mode))
      (spacemacs/set-leader-keys
        "pu" #'find-file-in-project
        "id" #'srecode-document-insert-function-comment
        "f z d" #'jz-open-current-file-of-folder
        "f z 2" #'jz-open-200-jz
        "je" #'avy-goto-char-2
        "jl" #'avy-goto-line
        "pb" #'helm-projectile-switch-to-buffer
        "po" #'find-file-in-project-at-point)
      (spacemacs/set-leader-keys-for-major-mode mode
        "oo" #'jz-toggle-cpp-h
        "hd" #'helm-gtags-dwim
        "fb" #'jz-clang-format
        "bq" #'jz-lsp-shutdown-workspace
        "yy" #'cpp-short-func-to-long-func
        "bs" #'jz-lsp-start-workspace)
      (setq ffip-use-rust-fd t)
      (setq ffip-project-file '(".svn" ".hg" ".git" ".projectile"))
      ;; (setq ffip-match-path-instead-of-filename t)
      (with-eval-after-load 'find-file-in-project
        (setq ffip-prune-patterns (append ffip-prune-patterns
                                          '("*/target/*" "*/snippets/*" "*/elpa/*" "*/.meghanada/*"))))
      )
    (spacemacs|add-company-backends :backends company-etags :modes c-mode-common)
    (spacemacs|add-company-backends :backends company-etags :modes go-mode)
    ))
(defun jz-tool/post-init-helm-gtags ()
  (dolist (mode c-c++-modes)
    (spacemacs/helm-gtags-define-keys-for-mode mode)))
(defun jz-tool/init-window-number ()
  (use-package window-number
    :config
    (window-number-mode 1)
    (spacemacs/set-leader-keys
      "1" #'jz-win-1
      "2" #'jz-win-2
      "3" #'jz-win-3
      "4" #'jz-win-4
      "5" #'jz-win-5)))



(defun jz-tool/init-evil-commentary ()
  (use-package evil-commentary
    :config
    (spacemacs/set-leader-keys
      "gc" #'jz-comment
      "cy" #'jz-comment-and-yank-down)))

(defun jz-tool/init-evil-surround ()
  (use-package evil-surround
    :config
    (global-evil-surround-mode 1)
    (evil-surround-mode 1)))


(defun jz-tool/init-rainbow-delimiters  ()
  (use-package rainbow-delimiters
    :config
    (add-hook 'c-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'c++-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'org-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'php-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'markdown-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'js-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'common-lisp-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'go-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)))


(defun jz-tool/init-evil-easymotion ()
  (use-package evil-easymotion
    :config
    ;; (define-key evil-normal-state-map (kbd "f") 'evil-avy-goto-char-2-below)
    ;; (define-key evil-normal-state-map (kbd "F") 'evil-avy-goto-char-2-above)
    ))
(defun jz-tool/init-symbol-overlay ()
  (use-package symbol-overlay
    :config
    (spacemacs/set-leader-keys
      "sC" 'symbol-overlay-remove-all
      "sh" 'symbol-overlay-put)
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "n") 'symbol-overlay-jump-next)
      (define-key map (kbd "p") 'symbol-overlay-jump-prev)
      (define-key map (kbd "r") 'symbol-overlay-toggle-in-scope)
      (define-key map (kbd "e") 'symbol-overlay-rename)
      (define-key map (kbd "h") nil)
      (setq symbol-overlay-map map))))

(defun jz-tool/init-expand-region ()
  (use-package expand-region
    :config
    (spacemacs/set-leader-keys
      "v" 'er/expand-region)))


(defun jz-tool/init-google-translate ()
  (use-package google-translate
    :init
    (defvar google-translate-base-url
      "http://translate.google.cn/translate_a/single")

    (defvar google-translate-listen-url
      "http://translate.google.cn/translate_tts")
    (defvar google-translate--tkk-url
      "http://translate.google.cn/")

    :config
    (spacemacs/set-leader-keys
      "W g t" #'jz-google-translate-at-point
      "W g T" #'google-translate-query-translate)
    ))

(defun jz-tool/init-leuven-theme ()
  (use-package leuven-theme
    :ensure t
    )
  )

(defun jz-tool/init-evil-args ()
  (use-package evil-args
    :config
    ;; bind evil-args text objects
      (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
      (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

      ;; bind evil-forward/backward-args
      (define-key c++-mode-map (kbd "<tab>") '(lambda ()
        (interactive)
        (if (in-brackets-pair-p)
          (progn
            (call-interactively 'evil-forward-arg)
            (evil-normal-state))
          (search-forward "(" (line-end-position) nil nil))))
      (define-key c++-mode-map (kbd "<backtab>")'(lambda ()
        (interactive)
        (if (in-brackets-pair-p)
          (progn
            (evil-normal-state)
            (call-interactively 'evil-backward-arg)))))

      ;; bind evil-jump-out-args
      (define-key evil-normal-state-map "K" 'evil-jump-out-args)
    ))

(defun jz-tool/init-evil-fringe-mark ()
  (use-package evil-fringe-mark
    :ensure t
    :config
    (global-evil-fringe-mark-mode)))

(defun jz-tool/init-wgrep-helm ()
  (use-package wgrep-helm
    :ensure t
    :config
    (setq wgrep-auto-save-buffer t)))

(defun jz-tool/init-treemacs ()
  (use-package treemacs
    :ensure t
    :config
    (spacemacs/set-leader-keys
      "0" #'jz-win-0
      "f t" #'treemacs)
    (define-key treemacs-mode-map "K" 'treemacs-goto-parent-node)
    (define-key treemacs-mode-map "r" 'treemacs-rename)
    (define-key treemacs-mode-map "d" 'treemacs-delete)
    (define-key treemacs-mode-map "c" 'treemacs-create-file)
    (define-key treemacs-mode-map "C" 'treemacs-create-dir)))

(defun jz-tool/init-treemacs-evil ()
  (use-package treemacs-evil
    :ensure t))

(defun jz-tool/init-treemacs-projectile ()
  (use-package treemacs-projectile
    :ensure t))
(defun jz-tool/init-format-all ()
  (use-package format-all
    :ensure t))


(defun my-mmm-markdown-auto-class (lang &optional submode)
 ;;Define a mmm-mode class for LANG in `markdown-mode' using SUBMODE.
 ;;If SUBMODE is not provided, use `LANG-mode' by default."
 (let ((class (intern (concat "markdown-" lang)))
       (submode (or submode (intern (concat lang "-mode"))))
       (front (concat "^```" lang "[\n\r]+"))
       (back "^```"))
   (mmm-add-classes (list (list class :submode submode :front front :back back)))
   (mmm-add-mode-ext-class 'markdown-mode nil class)))


(defun jz-tool/post-init-markdown-mode ()
  (use-package markdown-mode
    :config
    (setq markdown-fontify-code-blocks-natively t)
    ))

(defun jz-tool/init-keyfreq ()
  (use-package keyfreq
    :config
    (keyfreq-mode 1)
    (keyfreq-autosave-mode 1)))
(defun jz-tool/post-init-company ()
  (use-package company
    :config
    (define-key company-active-map (kbd "C-g") 'jz-keybord-quit-and-switch-2-evil-normal-mode)
    ))

; packages.el ends here
