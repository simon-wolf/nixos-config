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

        # git-related
        lazygit-nvim
        vim-gitgutter
        # gitsigns-nvim

        # files
        fzf-lua
        neo-tree-nvim
        #nerdtree
        #nerdtree-git-plugin
        oil-nvim
        project-nvim #Automagically cd to project directory

        # neo-tree dependencies
        #plenary-nvim
        image-nvim

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

        # Miscellaneous
        which-key-nvim # Shows available keybindings

        # Editing and Coding
        # cmp-nvim-lsp
        comment-nvim
        conform-nvim # Lightweight formatter
        fidget-nvim # UI for Neovim notifications and LSP progress messages
        nvim-lspconfig
        snacks-nvim # A collection of small QoL plugins for Neovim
        vim-sleuth # Auto-detect per-file tabs vs spaces and depth
      ];

      extraPackages = with pkgs; [
        # Language servers
        # elixir-ls
        lua-language-server
        marksman # Language server for Markdown
        # nil # Language server for Nix
        # nixd # Language server for Nix

        # Formatters
        # nixpkgs-fmt # Nix code formatter for nixpkgs
        stylua # Opinionated Lua code formatter

        # NOTE: These 'extra' lsp and formatters should be installed on a
        # per-project basis using nix shell

        # clang-tools
        # ltex-ls
        # omnisharp-roslyn
        # matlab-language-server
        # prettierd
        # black
      ];
   };
  };
}

