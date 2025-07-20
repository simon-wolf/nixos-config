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
        epkgs.eglot
        epkgs.magit
        epkgs.tree-sitter
        epkgs.tree-sitter-langs
        epkgs.treesit-grammars.with-all-grammars
      ];
      extraConfig = ''
        (setq standard-indent 2)
        (setq treesit-extra-load-path ("/run.current-system/sw/lib/"))
        (load-theme 'dracula t)
        (global-set-key [remap list-buffers] 'ibuffer)
        (set-frame-font "Inconsolata Nerd Font Mono 16" nil t)
      '';
    };
  };

  # home.file.".abcde.conf" = {
  #   source = ../config/abcde/abcde_lossless_flac.conf;
  #   recursive = false;
  # };
}
