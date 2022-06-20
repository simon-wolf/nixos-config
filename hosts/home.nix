#
# General Home-Manager configuration
#

{ config, libs, pkgs, user, ... }:

{
  imports = 
    (import ../modules/editors) ++
    (import ../modules/shell);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };

  home.file.".config/alacritty" = {
    source = ../config/alacritty;
    recursive = true;
  };
}
