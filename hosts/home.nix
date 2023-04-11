#
# General Home-Manager configuration
#

{ config, fetchurl, libs, pkgs, user, ... }:

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
      bc                    # Calculator
      btop                  # Resource manager
      cron                  # Command scheduler
      git                   # Git
      jq                    # JSON parser
      lazygit               # Git client
      maim                  # Screenshot utility
      pfetch                # Minimal Fetch
      pgcli                 # Command-line interface for PostgreSQL
      programmer-calculator # Calculator
      nnn                   # File Manager
      ranger                # File Manager
      restic                # Backup tool
      rsync                 # Backup tool
      tree                  # Directory Listing
      wally-cli             # Keyboard firmware flashing tool
      youtube-dl            # YouTube downloader

      # Audio & Video
      feh                   # Image Viewer
      mpv                   # Media Player
      pavucontrol           # Audio Control
      vlc                   # Media Player

      # File Management
      gnome.file-roller     # Archive Manager
      pcmanfm               # File Manager
      unzip                 # Zip Files
      unrar                 # Rar Files
      zip

      # General Applications
      _1password-gui
      atom                  # Text editor
      beekeeper-studio
      chromium
      # firefox             # Defined by the desktop 
      gnome.gnome-disk-utility
      gnome-obfuscate       # Censor private information in images
      gnome.simple-scan
      libreoffice-fresh
      mongodb-compass
      maestral              # Dropbox
      maestral-gui
      ngrok
      signal-desktop
      # slack
      tdesktop              # Telegram
      # teams
      thunderbird

      # Other
      bashmount             # Bash script for managing removable media with udisk
      evince                # GNOME document viewer
      gnome.gnome-keyring
      udisks                # Removable drive manipulation
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

  home.file.".config/nnn" = {
    source = ../config/nnn;
    recursive = true;
  };

  home.file.".config/pgcli" = {
    source = ../config/pgcli;
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

  home.file.".config/sway/wallpapers" = {
    source = ../config/sway/wallpapers;
    recursive = true;
  };

  home.file.".config/waybar" = {
    source = ../config/waybar;
    recursive = true;
  };
}
