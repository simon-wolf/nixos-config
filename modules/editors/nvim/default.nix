#
# Neovim
#

{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        # Syntax
        vim-elixir
        vim-git
        vim-json
        vim-nix
        vim-markdown
        lazygit-nvim
      ];
      
      extraConfig = ''
        syntax enable					" Syntax highlighting
        highlight Comment cterm=italic gui=italic	" Comments are italic
        set number					" Show line numbers
        set nofoldenable
      '';
    };
  };
}
