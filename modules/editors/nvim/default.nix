#
# Neovim
#
# See:
# 
# https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509
#
# https://gist.github.com/nat-418/493d40b807132d2643a7058188bff1ca
#

{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        # Icons
	mini-icons
	nvim-web-devicons

        fzf-lua

        # git-related
        lazygit-nvim
        vim-gitgutter
        # gitsigns-nvim

        # files
	oil-nvim
	nerdtree
        nerdtree-git-plugin

        (nvim-treesitter.withPlugins (
          plugins: with plugins; [
            bash
            csv
            dockerfile
            elixir
	    erlang
	    heex
	    html
	    javascript
	    jq
	    json
            latex
	    lua
            markdown
	    markdown_inline
            minimap-vim
            nix
	    python
	    ssh_config
	    vim
	    vimdoc
	    vim-gitgutter
	    xml
	  ]
	))

        # lualine
	nvim-web-devicons
	lualine-nvim

	# SnipMate
	vim-snipmate
        vim-snippets

	# Coding
	comment-nvim
	nvim-lspconfig

	# VimWiki
	vimwiki
      ];
      
#      extraConfig = ''
#        let NERDTreeMinimalUI=1
#        cabbrev tree NERDTree
#
#	let g:minimap_width = 10
#        let g:minimap_auto_start = 1
#        let g:minimap_auto_start_win_enter = 1
#	let g:minimap_git_colors = 1
#      '';
    };
  };
}

