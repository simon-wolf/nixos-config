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
        vimwiki
        lazygit-nvim
      ];
      
      extraConfig = ''
        syntax enable					" Syntax highlighting
        highlight Comment cterm=italic gui=italic	" Comments are italic
        set number					" Show line numbers
        set nofoldenable

        " Vim Wiki
        let g:vimwiki_list = [
        \   {'path': '~/notes/', 'syntax': 'markdown'},
        \   {'path': '~/Development/Mindme/sw_notes/', 'syntax': 'markdown', 'ext': '.md'}
        \ ]
        let g:vimwiki_global_ext = 0
        au FileType vimwiki setlocal shiftwidth=6 tabstop=6 noexpandtab
      '';
    };
  };
}

