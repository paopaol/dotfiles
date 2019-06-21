
;; It must be stored in your home directory.
;; 设置垃圾回收，在Windows下，emacs25版本会频繁出发垃圾回收，所以需要设�?
(when (eq system-type 'windows-nt)
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 15 t #'garbage-collect)
  ;; 显示垃圾回收信息，这个可以作为调试用
  (setq garbage-collection-messages t)
)
(setq inhibit-compacting-font-caches t) ; Don’t compact font caches during GC.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs-base

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(html
     ;; javascript
     restclient
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; themes-megapack
     auto-completion
     (helm
      :variables
      helm-position 'bottom
      helm-split-window-inside-p t
      helm-swoop-split-direction 'split-window-horizontally)
     gtags
     ;; better-defaults
     emacs-lisp
     ;; git
     markdown
     neotree
     cmake
     org
     (multiple-cursors :variables
                       multiple-cursors-backend 'evil-mc)
     ;; (shell :variables
     ;;        ;; shell-default-shell "cmd"
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     (shell :variables shell-default-term-shell "C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
     ;; spell-checking
     ;; syntax-checking
     version-control
     lsp
     (c-c++ :variables
           c-c++-default-mode-for-headers 'c++-mode
           c-c++-backend 'lsp-ccls)
     (go :variables go-backend 'lsp)
     jz-tool
     web-beautify)

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(
                                      ;; lsp-clangd
                                      ;; eglot
                                      ;; dakrone-light-theme
                                      ;; sr-speedbar
                                      evil-multiedit
                                      evil-snipe
                                      flycheck
                                      winum
                                      ;;window-number
                                      ;; tommyh-theme
                                      ;; find-file-in-project
                                      ;; color-theme-modern
                                      ;; vscode-icon
                                      ;; ccls
                                      )

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(default)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `vim-powerline' and `vanilla'. The first three
   ;; are spaceline themes. `vanilla' is default Emacs mode-line. `custom' is a
   ;; user defined themes, refer to the DOCUMENTATION.org for more info on how
   ;; to create your own spaceline theme. Value can be a symbol or list with\
   ;; additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   ;; dotspacemacs-default-font '("-outline-Consolas-normal-normal-normal-mono-20-*-*-*-c-*-iso8859-1"
   ;;                             :size 16
   ;;                             :weight normal
   ;;                             :width normal)
    dotspacemacs-default-font '("-outline-宋体-normal-normal-normal-*-12-*-*-*-p-*-iso8859-1"
                                :size 16
                                :weight bold
                                :width normal)
   ;;dotspacemacs-default-font '("-outline-微软雅黑-normal-normal-normal-sans-16----p--iso8859-1"
   ;;                            :size 16
   ;;                            :weight normal
   ;;                            :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers 'relative

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc�?
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
(setq configuration-layer-elpa-archives '(("melpa-cn" . "http://elpa.emacs-china.org/melpa/")
                                          ("org-cn" . "http://elpa.emacs-china.org/org/")
                                          ("gnu-cn" . "http://elpa.emacs-china.org/gnu/")))
;; (add-to-list 'eglot-server-programs '((c++ mode c-mode) . (eglot-cquery "cquery")))
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )





(defun jz-eglot-completion ()
  (interactive )
  (company-abort)
  (call-interactively 'company-lsp)
  )

(defun jz-evil-multi-edit-match-next ()
  (interactive)
  (evil-multiedit-match-and-next)
  (evil-multiedit-next)
  )

(defun jz-evil-multi-edit-match-prev ()
  (interactive)
  (evil-multiedit-match-and-prev)
  (evil-multiedit-prev)
  )
(defun jz-evil-multi-edit-skip-current ()
  (interactive)
  (evil-multiedit-toggle-or-restrict-region)
  )

(defun jz-lsp-ui-sideline-disable ()
  (lsp-ui-sideline-enable nil))




(setq projectile-globally-ignored-directories
  '(".idea"
    ".ensime_cache"
    ".eunit"
    ".git"
    ".hg"
    ".fslckout"
    "_FOSSIL_"
    ".bzr"
    "_darcs"
    ".tox"
    ".svn"
    "build"
    ".stack-work"))





(defcustom lsp-eldoc-hook'(lsp-hover)
  "Hooks to run for eldoc."
  :type 'hook
  :group 'lsp-mode)

(defvar c-c++-lsp-initialization-options '(:highlight (:largeFileSize 1) :compilationDatabaseDirectory "build/")
  "Extra initialisation parameters to pass to the lsp backend. See
https://github.com/MaskRay/ccls/blob/master/src/config.hh
for details. N.B. This is remapped to cquery-extra-init-params when using cquery backend")
(if (eq system-type 'windows-nt)
  (defvar c-c++-lsp-args '("--log-file=d:/1.log"))
  (defvar c-c++-lsp-args '("--log-file=/tmp/1.log"))
)

(defvar ggtags-highlight-tag-delay nil)








(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."


  ;; (require 'ivy)
  ;; (define-key ivy-minibuffer-map (kbd "<tab>") 'ivy-call-and-recenter)

  ;; (require 'helm-swoop)
  (require 'evil-multiedit)
  (require 'evil-snipe)
  (require 'lsp-mode)
  (require 'lsp)
  (add-hook 'c++-mode-hook #'lsp)
  (add-hook 'c-mode-hook #'lsp)

  (add-hook 'c++-mode-hook #'hs-minor-mode)
  (add-hook 'c-mode-hook #'hs-minor-mode)
  (add-hook 'go-mode-hook #'hs-minor-mode)
  (add-hook 'c++-mode-hook #'electric-pair-local-mode)
  (add-hook 'c-mode-hook #'electric-pair-local-mode)
  (add-hook 'go-mode-hook #'electric-pair-local-mode)
  (add-hook 'emacs-lisp-mode-hook #'electric-pair-local-mode)
  (add-hook 'common-lisp-mode-hook #'electric-pair-local-mode)
  (add-hook 'cmake-mode-hook #'electric-pair-local-mode)
  (require 'lsp-mode)
  (require 'flycheck)
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'c-mode-hook 'flycheck-mode)

  (use-package lsp-ui
    :ensure t
    :commands lsp-ui-mode
    :init
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    :config
    (setq lsp-ui-peek-enable t)
    (setq lsp-ui-doc-enable nil)
    (setq lsp-ui-imenu-enable t)
    (setq lsp-ui-flycheck-enable t)
    (setq lsp-ui-sideline-enable nil)
    (setq lsp-ui-sideline-ignore-duplicate t))



  (require 'winum)
  (winum-mode 1)

  ;; (add-hook 'go-mode-hook #'lsp-mode)
  (setenv "GTAGSTHROUGH" "true")
  ;; (setenv "GTAGSLIBPATH"
  ;;         "d:/msys64/mingw64/x86_64-w64-mingw32/include;d:/msys64/mingw64/include/c++/8.2.0")
(if (eq system-type 'windows-nt)
  (progn
    (setenv "GOPATH" "C:/Users/lenovo/go")
    (setenv "PATH" "D:/msys64/mingw64/bin;D:/msys64/usr/bin;C:/Windows/System32;C:/Windows;$GOPATH/bin;D:/Program Files/LLVM\bin")))
 
  (defun company-lsp--client-capabilities ()
    "Return the extra client capabilities supported by company-lsp."
    (when company-lsp-enable-snippet
      '(:textDocument (:completion (:completionItem (:snippetSupport t))))))


  ;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
  ;; incrementally add the next unmatched match.
  ;; (define-key evil-normal-state-map (kbd "M-d") 'jz-evil-multi-edit-match-next)
  ;; ;; Match selected region.
  ;; (define-key evil-visual-state-map (kbd "M-d") 'jz-evil-multi-edit-match-next)
  ;; ;; Insert marker at point
  ;; (define-key evil-insert-state-map (kbd "M-d") 'jz-evil-multi-edit-match-next)
  ;; ;; Same as M-d but in reverse.
  ;; (define-key evil-normal-state-map (kbd "C-M-d") 'jz-evil-multi-edit-match-prev)
  ;; (define-key evil-visual-state-map (kbd "C-M-d") 'jz-evil-multi-edit-match-prev)
  ;; (define-key evil-motion-state-map (kbd "RET") 'jz-evil-multi-edit-skip-current)

  (define-key evil-normal-state-map (kbd "C-j") 'next-line)
  (define-key evil-normal-state-map (kbd "C-k") 'previous-line)
  (define-key evil-insert-state-map (kbd "C-j") 'next-line)
  (define-key evil-insert-state-map (kbd "C-k") 'previous-line)
  (define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-insert-state-map (kbd "C-a") 'beginning-of-line)
  (define-key evil-normal-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-normal-state-map (kbd "C-a") 'beginning-of-line)
  (define-key evil-normal-state-map (kbd "C-f") 'forward-char)
  (define-key evil-normal-state-map (kbd "C-b") 'backward-char)

  (require 'helm-ag)

  (define-key helm-ag-mode-map (kbd "o") 'jz-helm-ag-preview-file)


  (require 'helm)
  (require 'ivy)

  (define-key helm-map (kbd "C-j") 'helm-next-line)
  (define-key helm-map (kbd "C-k") 'helm-previous-line)
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
  ;; (define-key helm-map (kbd "<tab>") 'jz-helm-ag-persistent-action)




  ;; 解决evil viw等命令无法包含下划线
  (with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol))

  (evil-snipe-mode 1)
  (evil-snipe-override-mode 1)
  ;; helm buffer display filename lenght
  (setq helm-buffer-max-length 56)

  ;; (global-set-key (kbd "C-,") 'ivy-restrict-to-matches)
  ;; (global-set-key (kbd "C-,") 'helm-make-reset-cache)

  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(company-backends (quote (company-dabbrev-code)))
 '(company-idle-delay 0)
 '(company-quickhelp-color-background "#e8e8e8")
 '(company-quickhelp-color-foreground "#444444")
 '(custom-safe-themes
   (quote
    ("19b9349a6b442a2b50e5b82be9de45034f9b08fa36909e0b1be09433234610bb" default)))
 '(display-line-numbers-type (quote relative))
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#eeeeee")
 '(global-display-line-numbers-mode t)
 '(helm-split-window-inside-p t)
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX" . "#dc752f")
     ("XXXX" . "#dc752f")
     ("???" . "#dc752f"))))
 '(lsp-enable-indentation nil)
 '(lsp-enable-on-type-formatting nil)
 '(lsp-enable-symbol-highlighting nil)
 '(lsp-ui-flycheck-list-position (quote bottom))
 '(lsp-ui-flycheck-live-reporting t)
 '(lsp-ui-peek-enable nil)
 '(lsp-ui-sideline-show-symbol nil)
 '(markdown-command
   "c:/ProgramData/chocolatey/bin/pandoc.exe --quiet --toc --standalone  --highlight-style=zenburn")
 '(markdown-css-paths
   (quote
    ("D:/root/home/workspace/jz/GitHub/markdown-css-themes/markdown8.css")))
 '(nrepl-message-colors
   (quote
    ("#8f4e8b" "#8f684e" "#c3a043" "#397460" "#54ab8e" "#20a6ab" "#3573b1" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (cc-engine evil-mc format-all web-mode tagedit slim-mode scss-mode sass-mode pug-mode impatient-mode helm-css-scss haml-mode emmet-mode counsel-css company-web web-completion-data add-node-modules-path treemacs-projectile treemacs-evil treemacs pfuture wgrep-helm ivy prettier-js livid-mode skewer-mode simple-httpd json-navigator hierarchy json-mode json-snatcher json-reformat js2-refactor js2-mode js-doc company-tern tern simple-bookmarks evil-fringe-mark leuven-theme emacs-leuven-theme doneburn-theme multiple-cursors org-present org-pomodoro alert log4e gntp org-mime org-download org-brain htmlize helm-org-rifle gnuplot evil-org symbol-overlay helm-ctest cmake-mode cmake-ide levenshtein google-c-style disaster cquery company-rtags rtags company-c-headers clang-format ccls flycheck-rtags flycheck git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-commit with-editor git-gutter diff-hl browse-at-remote evil-easymotion avy counsel swiper auto-indent-mode smartparens window-number helm-rtags wgrep smex ivy-yasnippet ivy-xref ivy-rtags ivy-purpose ivy-hydra counsel-gtags lsp-clangd yasnippet-snippets xterm-color ws-butler writeroom-mode winum which-key web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package tommyh-theme toc-org symon string-inflection sr-speedbar spaceline-all-the-icons shell-pop restclient-helm restart-emacs request rainbow-delimiters popwin persp-mode pcre2el password-generator paradox overseer org-plus-contrib org-bullets open-junk-file ob-restclient ob-http neotree nameless multi-term move-text markdown-toc macrostep lsp-ui lorem-ipsum link-hint indent-guide hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-xref helm-themes helm-swoop helm-purpose helm-projectile helm-mode-manager helm-make helm-gtags helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag google-translate golden-ratio godoctor go-tag go-rename go-impl go-guru go-gen-test go-fill-struct go-eldoc gh-md ggtags fuzzy font-lock+ flx-ido find-file-in-project fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-snipe evil-numbers evil-nerd-commenter evil-multiedit evil-matchit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help elisp-slime-nav editorconfig dumb-jump dotenv-mode doom-modeline diminish define-word counsel-projectile company-statistics company-restclient company-lsp company-go column-enforce-mode clean-aindent-mode centered-cursor-mode auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e")))
 '(safe-local-variable-values
   (quote
    ((project-root . ".")
     (javascript-backend . tern)
     (javascript-backend . lsp)
     (go-backend . go-mode)
     (go-backend . lsp))))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(vc-annotate-background "#f9f9f9")
 '(vc-annotate-color-map
   (quote
    ((20 . "#844880")
     (40 . "#8f4e8b")
     (60 . "#8f684e")
     (80 . "#cfb56e")
     (100 . "#c3a043")
     (120 . "#c3a043")
     (140 . "#2a5547")
     (160 . "#397460")
     (180 . "#3b7863")
     (200 . "#438972")
     (220 . "#4c9a80")
     (240 . "#54ab8e")
     (260 . "#20a6ab")
     (280 . "#234d76")
     (300 . "#295989")
     (320 . "#2e659c")
     (340 . "#3573b1")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((t (:background "#FFE1E1FF" :foreground "red" :underline (:color "#e0211d" :style wave) :weight bold))))
 '(flycheck-fringe-info ((t (:inherit bold :foreground "#4f97d7"))))
 '(flycheck-fringe-warning ((((class color) (min-colors 257)) (:foreground "#FFAC4A" :background unspecified :weight bold)) (((class color) (min-colors 89)) (:foreground "#FFAF5F" :background unspecified :weight bold))))
 '(flycheck-info ((t (:underline (:color "#4f97d7" :style wave) :weight bold))))
 '(flycheck-warning ((t (:background "000000FF" :foreground "orchid" :underline (:color "red" :style wave) :weight bold))))
 '(highlight ((t nil)))
 '(which-func ((t (:foreground "Blue1" :weight bold)))))
)
