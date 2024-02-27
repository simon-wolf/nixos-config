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
        lazygit-nvim
        nerdtree
        nerdtree-git-plugin
        vim-elixir
        vim-git
        vim-json
        vim-markdown
        vim-nix
      ];
      
      extraConfig = ''
        syntax enable					" Syntax highlighting
        highlight Comment cterm=italic gui=italic	" Comments are italic
        set number					" Show line numbers
        set nofoldenable
        set spelllang=en_gb
        set spell

        let NERDTreeMinimalUI=1

        cabbrev tree NERDTree
      '';
    };
  };
}

