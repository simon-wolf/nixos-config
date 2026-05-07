(tool-bar-mode 0)

;; Show line numbers in text and programming modes
(add-hook 'text-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Show the column number in the mode line (line number is shown by default)
(setq column-number-mode t)

(setq standard-indent 2)

;; Split windows horizontally: []|[]
(setq split-width-threshold 1)


(global-set-key (kbd "M-o") 'other-window)

(load-theme 'dracula t)
(global-set-key [remap list-buffers] 'ibuffer)
(set-frame-font "Inconsolata Nerd Font Mono 16" nil t)

;; Spelling
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(setq ispell-program-name "aspell"
       ispell-dictionary "en_GB-ise-wo_accents")


(use-package emacs
  :ensure nil
  ;; :custom



  ;; Should use:
  ;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
  ;; at least once per installation or while changing this list

  ;;(treesit-language-source-alist
  ;; '((heex "https://github.com/phoenixframework/tree-sitter-heex")
  ;;   (elixir "https://github.com/elixir-lang/tree-sitter-elixir")))

  ;;(major-mode-remap-alist
  ;; '((elixir-mode . elixir-ts-mode)))
)

(use-package tree-sitter-langs ;; grammar bundle
  :after tree-sitter
  :custom (global-tree-sitter-mode t))

(use-package treesit-auto ;; auto-install missing grammars
  :after tree-sitter
  :config (global-treesit-auto-mode))

(use-package treesit-fold ;; enable code folding based on tree-sitter
  ;; :vc (:url "https://github.com/emacs-tree-sitter/treesit-fold")
  :config (treesit-fold-mode)
  :bind
  (("C-`" . treesit-fold-toggle)
  ("C-€" . treesit-fold-close-all) ;; I remap S-` to € using `keyd` so can't use C-S-`
  ("M-C-€" . treesit-fold-open-all)))

(use-package dockerfile-ts-mode
  :mode "\\Dockerfile\\'"
  :config (add-to-list 'major-mode-remap-alist '((docker-mode . docker-ts-mode))))

(use-package nix-ts-mode
  :mode "\\.nix\\'"
  :config (add-to-list 'major-mode-remap-alist '((nix-mode . nix-ts-mode))))



(use-package yasnippet
  :ensure t
  :hook ((text-mode
          prog-mode
          conf-mode
          snippet-mode) . yas-minor-mode-on)
  :init
    (setq yas-snippet-dir '("~/.config/emacs/snippets"))
    (yas-global-mode 1))

;; Specify a separate custom-file and load it
;; (setq custom-file "~/.emacs.d/custom.el")
;; (load custom-file)

;; Improve *Completions* buffer behaviour
(setq completion-auto-help 'always)
(setq completion-auto-select 'second-tab)

;; Associate all org files with org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Make indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)

;; Hide the markers so you just see bold text as BOLD-TEXT and not *BOLD-TEXT*
(setq org-hide-emphasis-markers t)

;; Wrap the lines in org mode so that things are easier to read
(add-hook 'org-mode-hook 'visual-line-mode)

