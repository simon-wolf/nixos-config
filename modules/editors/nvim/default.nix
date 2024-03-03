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
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        fzfWrapper
        lazygit-nvim
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
	    markdown
	    markdown_inline
	    nix
	    python
	    ssh_config
	    xml
	  ]
	))
      ];
      
      extraConfig = ''
        syntax enable					" Syntax highlighting
        highlight Comment cterm=italic gui=italic	" Comments are italic
        set number					" Show line numbers
        set nofoldenable
        set spelllang=en_gb
        set nospell

        let NERDTreeMinimalUI=1

        cabbrev tree NERDTree
      '';
    };
  };
}

