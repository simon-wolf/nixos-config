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
      '';

      shellAliases = {
        mm = "~/Development/Mindme/scripts/mm";
      };
    };
  };

  home.file.".config/zsh_nix/external/prompt_purification_setup" = {
    source = ../../config/zsh/external/prompt_purification_setup;
  };
}
