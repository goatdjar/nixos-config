;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; =============================================================================
;; 1. PERSONAL IDENTITY & CORE SYSTEM
;; =============================================================================
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

(setq gcmh-high-cons-threshold (* 128 1024 1024)) ; 128MB Startup performance
(setq persp-sort 'created)                        ; Fast workspace layout switching
(setq echo-keystrokes 0)                           ; Silence keystroke echo in minibuffer

;; Encoding defaults
(setq doom-modeline-buffer-encoding t)
(setq-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8)


;; =============================================================================
;; 2. LOOKS, UI & FRAMES
;; =============================================================================
(setq doom-theme 'doom-gruvbox)
(setq display-line-numbers-type 'visual)

;; Dashboard adjustments (Hide ASCII banner cleanly)
(after! doom-dashboard
  (setq +doom-dashboard-functions
        '(doom-dashboard-widget-shortmenu
          doom-dashboard-widget-loaded)))
(setq +doom-dashboard-ascii-banner-fn nil)

;; Frame layouts
(add-to-list 'default-frame-alist '(fullscreen . fullscreen))
(custom-set-faces! '(default :background nil)) ; True transparency / background passthrough
(solaire-global-mode +1)                       ; Dim inactive windows

;; Font configurations
(setq doom-font (font-spec :family "Iosevka" :size 20 :weight 'regular))
(setq doom-font-increment 0.5)

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-doc-face :slant italic)
  '(flycheck-error :underline nil :inherit nil)   ; Clear terminal errors
  '(flycheck-warning :underline nil :inherit nil))


;; =============================================================================
;; 3. EDITING, INDENTATION & CURSORS
;; =============================================================================
;; Core layout & indentation widths
(setq-default tab-width 4)
(setq-default standard-indent 4)
(setq evil-shift-width 4)

;; Indent guides styling
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-char ?:)
(setq highlight-indent-guides-responsive 'character)

;; Cursor styles (Blink-free dynamic blocks)
(blink-cursor-mode 0)
(setq-default cursor-type 'box)
(setq evil-default-cursor      '("#32CD32" box)   ;; Lime Green
      evil-normal-state-cursor   '("#32CD32" box)
      evil-insert-state-cursor   '("#ff6c6b" box)   ;; Soft Red
      evil-visual-state-cursor   '("#f78c6c" box)   ;; Coral
      evil-replace-state-cursor  '("#c678dd" box)   ;; Magenta
      evil-motion-state-cursor   'box
      evil-operator-state-cursor 'box)


;; =============================================================================
;; 4. COMPLETION ENGINE (CORFU & CAPE)
;; =============================================================================
(after! corfu
  (setq corfu-auto t
        corfu-auto-delay 0.1
        corfu-auto-prefix 1
        corfu-quit-at-boundary 'separator))

(after! corfu-terminal
  (unless (display-graphic-p)
    (corfu-terminal-mode +1)))

(after! cape
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword))


;; =============================================================================
;; 5. GLOBAL LSP & WORKSPACES
;; =============================================================================
(setq org-directory "~/org/")

(after! lsp-mode
  (setq lsp-idle-delay 0.5
        lsp-before-save-edits nil))

(after! projectile
  (add-to-list 'projectile-project-root-files "pyproject.toml")
  (add-to-list 'projectile-project-root-files "uv.lock"))


;; =============================================================================
;; 6. LANGUAGE INTERFACES & TOOLING
;; =============================================================================
;; Nix
(setq lsp-nix-nixd-server-path "nixd")
(after! lsp-mode
  (setq lsp-nix-nixd-nixpkgs-expr "import <nixpkgs> { }"))
(add-hook 'nix-mode-hook #'lsp!)

;; Go
(setq lsp-go-analyses
      '((nilness . t)
        (unusedparams . t)
        (unusedwrite . t)
        (useany . t)))
(setq +format-with-lsp t)

;; Python (Pyright + Ruff)
(after! lsp-pyright
  (setq lsp-pyright-langserver-command "pyright"))
(setq-hook! 'python-mode-hook +format-with 'ruff)
(setq-hook! 'python-ts-mode-hook +format-with 'ruff)

;; Rust
(after! lsp-rust
  (setq lsp-inlay-hints-mode t))

;; Infrastructure & Protocol Formats
(setq terraform-command "tofu")
(use-package! protobuf-mode
  :mode "\\.proto\\'")


;; =============================================================================
;; 7. POPUPS & BUFFER RULES
;; =============================================================================
;; CRITICAL: Fixed. Rules must live globally, outside of 'after!' blocks.
(set-popup-rule! "^\\*cargo-run" :side 'top :size 0.40 :quit t :select nil)


;; =============================================================================
;; 8. KEYBINDINGS & WINDOW MANIPULATION
;; =============================================================================
;; Vim-style raw keystroke paste-and-indent
(map! :n "]p" "p`[v`]>")
(map! :n "[p" "P`[v`]>")

;; Remap buffer searching (Frees up C-s)
(map! :nv "M-s" #'+default/search-buffer)
(map! :n "C-s" #'save-buffer
      :i "C-s" #'save-buffer)

;; Global escape-hatch: Clear search match / fallback to normal state
(map! :n "C-c" #'evil-ex-nohighlight
      :i "C-c" #'evil-normal-state
      :v "C-c" #'evil-normal-state)

(after! vterm
  (map! :map vterm-mode-map :ni "C-c" #'vterm-send-C-c))

;; Vim-esque newline insertion from normal mode without leaving normal mode
(map! :map (text-mode-map prog-mode-map)
      :n "<return>"  #'+evil/insert-newline-below
      :n "<S-return>" #'+evil/insert-newline-above)

;; Leader shortcuts
(map! :leader
      (:prefix-map ("r" . "run")
       :desc "Run current file" "r" #'quickrun))

;; Transient window resizing state (Press SPC w . followed by < > + -)
(define-prefix-command 'my-window-resize-map)
(define-key my-window-resize-map (kbd "<") (lambda () (interactive) (shrink-window-horizontally -3) (set-transient-map my-window-resize-map t)))
(define-key my-window-resize-map (kbd ">") (lambda () (interactive) (shrink-window-horizontally 3)  (set-transient-map my-window-resize-map t)))
(define-key my-window-resize-map (kbd "+") (lambda () (interactive) (enlarge-window 3)              (set-transient-map my-window-resize-map t)))
(define-key my-window-resize-map (kbd "-") (lambda () (interactive) (enlarge-window -3)             (set-transient-map my-window-resize-map t)))

(map! :leader
      :desc "Resize mode" "w ." (lambda () (interactive) (set-transient-map my-window-resize-map t)))
