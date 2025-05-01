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
        fzf-lua
        lazygit-nvim
        nerdtree
        nerdtree-git-plugin
	# nvim-treesitter.withAllGrammars
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
      ];
      
      extraConfig = ''
        syntax enable					" Syntax highlighting
        highlight Comment cterm=italic gui=italic	" Comments are italic
        set nofoldenable
        set spelllang=en_gb
        set nospell

        nnoremap <C-p> :FzfLua files<Cr>

        let NERDTreeMinimalUI=1

        cabbrev tree NERDTree

	let g:minimap_width = 10
        let g:minimap_auto_start = 1
        let g:minimap_auto_start_win_enter = 1
	let g:minimap_git_colors = 1

	" Git Gutter
	highlight GitGutterAdd guifg=#009900 ctermfg=Green
	highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
	highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
	nmap ) <Plug>(GitGutterNextHunk)
	nmap ( <Plug>(GitHuggerPrevHunk)
	let g:gitgutter_enabled = 1
	let gitgutter_map_keys = 0
	" let g:airline_theme = 'codedark'
      '';
    };
  };
}

