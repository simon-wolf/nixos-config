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

    packages = with pkgs; [
      # Terminal
      alacritty             # Terminal emulator
      btop                  # Resource manager
      git                   # Git
      jq                    # JSON parser
      lazygit               # Git client
      maim                  # Screenshot utility
      pfetch                # Minimal Fetch
      nnn                   # File Manager
      ranger                # File Manager
      tree                  # Directory Listing

      # Audio & Video
      feh                   # Image Viewer
      mpv                   # Media Player
      pavucontrol           # Audio Control
      vlc                   # Media Player

      # File Management
      gnome.file-roller     # Archive Manager
      pcmanfm               # File Manager
      rsync                 # Syncer $ rsync -r dir1/ dir2/
      unzip                 # Zip Files
      unrar                 # Rar Files

      # General Applications
      _1password-gui
      beekeeper-studio
      # firefox             # Defined by the desktop 
      insomnia
      libreoffice
      mongodb-compass
      ngrok
      signal-desktop
      teams

      # Other
      bashmount             # Bash script for managing removable media with udisk
      fontmatrix            # Font viewer
      iwgtk                 # Graphical WiFi management tool
      udisks                # Removable drive manipulation
      zathura               # PDF viewer
    ];

    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };

  home.file.".config/alacritty" = {
    source = ../config/alacritty;
    recursive = true;
  };

  home.file.".config/sway/config" = {
    source = ../config/sway/config;
    recursive = false;
  };

  home.file.".config/sway/scripts/lower_brightness.sh" = {
    source = ../config/sway/scripts/lower_brightness.sh;
    executable = true;
  };

  home.file.".config/waybar" = {
    source = ../config/waybar;
    recursive = true;
  };
}
