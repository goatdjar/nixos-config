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
;; maintain terminal transparency cleanly without breaking gui frames
(after! doom-themes
  (unless (display-graphic-p)
    (set-face-background 'default "unspecified")))
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

;; Add Starknet project root
(after! projectile
  (add-to-list 'projectile-project-root-files "pyproject.toml")
  (add-to-list 'projectile-project-root-files "uv.lock")
  (add-to-list 'projectile-project-root-files "Scarb.toml"))


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


;; =============================================================================
;; 9. FOR EVALUATION SECTION
;; =============================================================================

;; 1. Use generic programming mode for .cairo to bypass rust-analyzer entirely
(add-to-list 'auto-mode-alist '("\\.cairo\\'" . prog-mode))

;; ;; 2. Manually inject Cairo & Starknet syntax highlighting keywords into prog-mode
;; (defvar cairo-font-lock-keywords
;;   (list
;;    ;; Keywords
;;    (cons (regexp-opt '("fn" "let" "mut" "struct" "enum" "use" "mod" "impl" "trait" "const" "type"
;;                        "if" "else" "loop" "while" "for" "in" "return" "match" "break" "continue"
;;                        "as" "of" "pub" "extern" "ref" "static") 'words)
;;          'font-lock-keyword-face)
;;    ;; Starknet Attributes & Macros
;;    (cons (regexp-opt '("#[starknet::contract]" "#[starknet::interface]" "#[abi(embed_v0)]"
;;                        "#[storage]" "#[event]" "#[external]" "#[view]" "#[constructor]"
;;                        "#[generate_trait]") 'words)
;;          'font-lock-preprocessor-face)
;;    ;; Common Data Types
;;    (cons (regexp-opt '("u8" "u16" "u32" "u64" "u128" "u256" "usize" "bool" "felt252" "ContractAddress") 'words)
;;          'font-lock-type-face)
;;    ;; Constants/Booleans
;;    (cons (regexp-opt '("true" "false") 'words)
;;          'font-lock-constant-face))
;;   "Basic syntax highlighting tokens for the Cairo Language.")

;; 2. Manually inject Cairo & Starknet syntax highlighting keywords into prog-mode
(defvar cairo-font-lock-keywords
  (list
   ;; Keywords
   (cons (regexp-opt '("fn" "let" "mut" "struct" "enum" "use" "mod" "impl" "trait" "const" "type"
                       "if" "else" "loop" "while" "for" "in" "return" "match" "break" "continue"
                       "as" "of" "pub" "extern" "ref" "static") 'words)
         'font-lock-keyword-face)
   ;; Starknet Attributes & Macros
   (cons (regexp-opt '("#[starknet::contract]" "#[starknet::interface]" "#[abi(embed_v0)]"
                       "#[storage]" "#[event]" "#[external]" "#[view]" "#[constructor]"
                       "#[generate_trait]") 'words)
         'font-lock-preprocessor-face)
   ;; Common Data Types
   (cons (regexp-opt '("u8" "u16" "u32" "u64" "u128" "u256" "usize" "bool" "felt252" "ContractAddress") 'words)
         'font-lock-type-face)
   ;; Constants/Booleans
   (cons (regexp-opt '("true" "false") 'words)
         'font-lock-constant-face))
  "Basic syntax highlighting tokens for the Cairo Language.")

;; (add-hook 'prog-mode-hook
;;           (lambda ()
;;             (when (string-match-p "\\.cairo\\'" (or buffer-file-name ""))
;;               (setq-local comment-start "//")
;;               (setq-local comment-end "")
;;               ;; Assign the highlighting keywords defined above
;;               (setq font-lock-defaults '(cairo-font-lock-keywords))
;;               ;; Force Emacs to repaint the buffer text
;;               (font-lock-ensure))))
(add-hook 'prog-mode-hook
          (lambda ()
            (when (string-match-p "\\.cairo\\'" (or buffer-file-name ""))
              (setq-local comment-start "//")
              (setq-local comment-end "")

              ;; --- ADDED FOR 4-SPACE TABS ---
              (setq-local indent-tabs-mode nil) ; Use spaces instead of tabs
              (setq-local tab-width 4)           ; Visual width of a tab is 4 spaces
              ;; ------------------------------

              ;; Assign the highlighting keywords defined above
              (setq font-lock-defaults '(cairo-font-lock-keywords))
              ;; Force Emacs to repaint the buffer text
              (font-lock-ensure))))

;; 3. Register the Scarb LSP cleanly under prog-mode
(after! lsp-mode
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("scarb" "cairo-language-server"))
                    :major-modes '(prog-mode)
                    :priority 10
                    :server-id 'cairo-ls
                    :activation-fn (lambda (filename _mode)
                                     (string-match-p "\\.cairo\\'" (or filename "")))))

  ;; Suppress warning popup frames cleanly
  (add-to-list 'warning-suppress-types '(lsp-mode)))

;; 4. Automatically trigger LSP connections for Cairo buffers
(add-hook 'prog-mode-hook
          (lambda ()
            (when (string-match-p "\\.cairo\\'" (or buffer-file-name ""))
              (lsp-deferred))))

;; ;; Cario shizz
;; ;; Cairo (Starknet Smart Contracts using Rust Major Mode)
;; (define-derived-mode cairo-mode rust-mode "Cairo"
;;   "Major mode for editing Cairo smart contracts.")

;; (use-package! cairo-mode
;;   :mode "\\.cair\\'"
;;   :mode "\\.cairo\\'"
;;   :config
;;   ;; Hook our custom mode into Doom's LSP engine
;;   (add-hook 'cairo-mode-hook #'lsp-deferred)

;;   ;; Bind Scarb's compiler language server to this specific mode
;;   (after! lsp-mode
;;     (lsp-register-client
;;      (make-lsp-client :new-connection (lsp-stdio-connection '("scarb" "cairo-language-server"))
;;                       :major-modes '(cairo-mode)
;;                       :server-id 'cairo-ls))))
