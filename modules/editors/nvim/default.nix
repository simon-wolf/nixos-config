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
        fzf-vim
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
            latex
            markdown
	    markdown_inline
            minimap-vim
            nix
	    python
	    ssh_config
	    vim-gitgutter
	    xml
	  ]
	))
	# lualine
	nvim-web-devicons
	lualine-nvim
	
	vim-snipmate
        vim-snippets
      ];
      
      extraConfig = ''
        syntax enable					" Syntax highlighting
        highlight Comment cterm=italic gui=italic	" Comments are italic
        set nofoldenable
        set spelllang=en_gb
        set nospell

        nnoremap <C-p> :Files<Cr>

        let NERDTreeMinimalUI=1

        cabbrev tree NERDTree

        set clipboard+=unnamedplus

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

      extraLuaConfig = ''
        vim.opt.number = true

        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = 'everforest',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
              statusline = {},
              winbar = {}
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = false,
            refresh = {
              statusline = 100,
              tabline = 100,
              winbar = 100
            }
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {
              {
                'buffers',
                show_filename_only = true,   -- Shows shortened relative path when set to false.
                hide_filename_extension = false,   -- Hide filename extension when set to true.
                show_modified_status = true, -- Shows indicator when the buffer is modified.

                mode = 4, -- 0: Shows buffer name
                          -- 1: Shows buffer index
                          -- 2: Shows buffer name + buffer index
                          -- 3: Shows buffer number
                          -- 4: Shows buffer name + buffer number

                max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
                                                    -- it can also be a function that returns
                                                    -- the value of `max_length` dynamically.
                filetype_names = {
                  TelescopePrompt = 'Telescope',
                  dashboard = 'Dashboard',
                  packer = 'Packer',
                  fzf = 'FZF',
                  alpha = 'Alpha',
                }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

                -- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
                use_mode_colors = true,

                -- buffers_color = {
                  -- Same values as the general color option can be used here.
                --   active = 'lualine_{section}_normal',     -- Color for active buffer.
                --   inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
                -- },

                symbols = {
                  modified = ' ●',      -- Text to show when the buffer is modified
                  alternate_file = '#', -- Text to show to identify the alternate file
                  directory =  '',     -- Text to show when the buffer is a directory
                },
              },
            },

            lualine_x = {'encoding'},
	    lualine_y = {'progress'},
            lualine_z = {'location'}
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
          },
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = {}
        }
      '';
    };
  };
}

