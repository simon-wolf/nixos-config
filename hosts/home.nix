#
# General Home-Manager configuration
#

{ config, fetchurl, libs, pkgs, user, ... }:

{
  imports = 
    (import ../modules/editors) ++
    (import ../modules/shell);

#    nixpkgs.overlays = [
#      (self: super: {
#        insomnia = super.insomnia.overrideAttrs (old: {
#          version = "2022.5.1";
#          src = fetchurl {
#            url =
#          "https://github.com/Kong/insomnia/releases/download/core%40${self.version}/Insomnia.Core-${self.version}.deb";
#            sha256 = "sha256-ExdfXfpimM6E/S6xiLTHdq3f4/ydtyfZ2+9o32z87gc=";
#          };
#        });
#      } )
#    ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Terminal
      alacritty             # Terminal emulator
      bc                    # Calculator
      btop                  # Resource manager
      git                   # Git
      jq                    # JSON parser
      lazygit               # Git client
      maim                  # Screenshot utility
      pfetch                # Minimal Fetch
      programmer-calculator # Calculator
      nnn                   # File Manager
      ranger                # File Manager
      tree                  # Directory Listing
      wally-cli             # Keyboard firmware flashing tool

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
      atom                  # Text editor
      beekeeper-studio
      # firefox             # Defined by the desktop 
      gnome.gnome-disk-utility
      gnome.simple-scan
      libreoffice
      mongodb-compass
      ngrok
      signal-desktop
      slack
      tdesktop              # Telegram
      teams
      thunderbird-102-wayland

      # Other
      bashmount             # Bash script for managing removable media with udisk
      evince                # GNOME document viewer
      fontmatrix            # Font viewer
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
