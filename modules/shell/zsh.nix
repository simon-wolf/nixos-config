#
# Zsh
#

{ pkgs, config, ... }:

{
  programs = {
    zsh = {
      enable = true;
      dotDir = "${config.home.homeDirectory}/.config/zsh_nix";
      # enableAutosuggestions = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;                 # Maximum events in internal history
      history.save = 10000;                 # Maximum events in history file

      initContent = ''
        # Prompt
        source $HOME/.config/zsh_nix/external/prompt_purification_setup
        autoload -Uz prompt_purification_setup; prompt_purification_setup

        # nnn
        # export NNN_PLUG="p:evince"
        # export NNN_FCOLORS='0000E6310000000000000000'
        export NNN_FIFO="/tmp/nnn.fifo"
        export NNN_BMS="M:$HOME/Dropbox_mm/Marketing\ and\ Media/Devices;D:$HOME/Development/Mindme/v3_platform"
      '';

      shellAliases = {
        mm = "~/Development/Mindme/scripts/mm";
        view = "evince";
        nnn = "nnn -e";
        ll = "nnn -de";
      };
    };
  };

  home.file.".config/zsh_nix/external/prompt_purification_setup" = {
    source = ../../config/zsh/external/prompt_purification_setup;
  };
}
