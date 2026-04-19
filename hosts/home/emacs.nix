#
# Emacs configuration
#

{ config, fetchurl, libs, pkgs, user, ... }:
{
  programs = {
    emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages = epkgs: [
        epkgs.dracula-theme
        epkgs.eldoc-box
        epkgs.lsp-pyright
        # epkgs.eglot
        epkgs.magit
        epkgs.nix-mode
        epkgs.tree-sitter
        epkgs.tree-sitter-langs
        epkgs.treesit-grammars.with-all-grammars
        # epkgs.use-package
        epkgs.yasnippet
      ];
      extraConfig = ''
        (setq standard-indent 2)
        (tool-bar-mode 0)

        (setq treesit-extra-load-path ("/run.current-system/sw/lib/"))
        (load-theme 'dracula t)
        (global-set-key [remap list-buffers] 'ibuffer)
        (set-frame-font "Inconsolata Nerd Font Mono 16" nil t)

        (use-package
         emacs
         :ensure nil
         :custom

         ;; Should use:
         ;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
         ;; at least once per installation or while changing this list
         (treesit-language-source-alist
          '((heex "https://github.com/phoenixframework/tree-sitter-heex")
            (elixir "https://github.com/elixir-lang/tree-sitter-elixir")))

         (major-mode-remap-alist
          '((elixir-mode . elixir-ts-mode)))
        )

        (use-package yasnippet
          :ensure t
          :hook ((text-mode
                  prog-mode
                  conf-mode
                  snippet-mode) . yas-minor-mode-on)
          :init
          (setq yas-snippet-dir '("~/.emacs.d/snippets"))
          (yas-global-mode 1))

        ;; Associate all org files with org mode
        (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

        ;; Make indentation look nicer
        (add-hook 'org-mode-hook 'org-indent-mode)

        ;; Hide the markers so you just see bold text as BOLD-TEXT and not *BOLD-TEXT*
        (setq org-hide-emphasis-markers t)

        ;; Wrap the lines in org mode so that things are easier to read
        (add-hook 'org-mode-hook 'visual-line-mode)
      '';
    };
  };

  # home.file.".abcde.conf" = {
  #   source = ../config/abcde/abcde_lossless_flac.conf;
  #   recursive = false;
  # };
}
