#
# Zsh
#

{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh_nix";
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      history.size = 10000;                 # Maximum events in internal history
      history.save = 10000;                 # Maximum events in history file

      initExtra = ''
        # Prompt
        source $HOME/.config/zsh_nix/external/prompt_purification_setup
        autoload -Uz prompt_purification_setup; prompt_purification_setup

        # nnn
        # export NNN_PLUG="p:evince"
        # export NNN_FCOLORS='0000E6310000000000000000'
        alias nnn "nnn -e"
        alias ll "nnn -de"
        export NNN_FIFO="/tmp/nnn.fifo"
      '';

      shellAliases = {
        mm = "~/Development/Mindme/scripts/mm";
        view = "evince";
      };
    };
  };

  home.file.".config/zsh_nix/external/prompt_purification_setup" = {
    source = ../../config/zsh/external/prompt_purification_setup;
  };
}
