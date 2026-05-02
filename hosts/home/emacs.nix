#
# Emacs configuration
#

{ config, fetchurl, libs, pkgs, user, ... }:
{
  programs = {
    emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages =
        epkgs: with epkgs; ([
          dracula-theme
          eldoc-box
          lsp-pyright
          # epkgs.eglot
          magit
          multiple-cursors
          nix-mode
          nix-ts-mode
          transpose-frame
          # epkgs.tree-sitter
          # epkgs.tree-sitter-langs
          # epkgs.treesit-grammars.with-all-grammars
          # epkgs.use-package
          treesit-fold
          yasnippet

          # Elixir
          elixir-ts-mode
          heex-ts-mode

          tree-sitter-langs
          (treesit-grammars.with-grammars (p: [
            p.tree-sitter-bash
            p.tree-sitter-dockerfile
            p.tree-sitter-elisp
            p.tree-sitter-elixir
            p.tree-sitter-heex
            p.tree-sitter-markdown
            p.tree-sitter-markdown-inline
            p.tree-sitter-nix
            p.tree-sitter-ocaml
            p.tree-sitter-python
            p.tree-sitter-toml
            p.tree-sitter-typst
            p.tree-sitter-yaml
          ]))
        ]);
    };
  };
}
