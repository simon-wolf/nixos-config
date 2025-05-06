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
        # Theme
        kanagawa-nvim

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
            minimap-vim
            nix
            python
            query
            ssh_config
            vim
            vimdoc
            vim-gitgutter
            xml
          ]
        ))

        # lualine
        lualine-nvim

        # SnipMate
        vim-snipmate
        vim-snippets

        # Editing and Coding
        comment-nvim
        nvim-lspconfig
        vim-sleuth # Auto-detect per-file tabs vs spaces and depth
      ];
    };
  };
}

