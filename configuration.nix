# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  # bash script to let dbus know about important env variables and
  # propogate them to relevant services run at the end of sway config
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire wireplumber pipewire-pulse xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire wireplumber pipewire-pulse xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # Use the XDG_DATA_DIR environmental variable to tell gsettings where
  # the schemas are. Run this at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };

  vscode_extensions = (with pkgs.vscode-extensions; [
    jakebecker.elixir-ls
    ms-python.python
    ms-python.vscode-pylance
    stkb.rewrap
    tomoki1207.pdf
  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-elixir-credo";
      publisher = "pantajoe";
      version = "0.7.2";
      sha256 = "036lknj1vs42g1zxsbzh692czl6rkzpffvqn15n5yz4ps33gvhy5";
    }
    {
      name = "phoenix";
      publisher = "phoenixframework";
      version = "0.1.1";
      sha256 = "0pd1s6f1lm96y1q9d9aj7sa8n0vc0cjrggiyyh1azwa5h59v1w01";
    }
    {
      name = "uuid-generator";
      publisher = "netcorext";
      version = "0.0.5";
      sha256 = "01mhzmc8ck2rk8nr9pqgkp2qk508ssx8asis27ll9vjmw38liiys";
    }
  ];
  vscode-with-extensions = pkgs.vscode-with-extensions.override {
    vscodeExtensions = vscode_extensions;
  };

  user="simon";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  console.earlySetup = true;  # Use larger font during boot

  networking.hostName = "nixos-lite2"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    packages = with pkgs; [ terminus_font ];
    font = "ter-i32b";
    keyMap = "uk";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = true;
  users.users.${user} = {
    isNormalUser = true;
    description = "Simon Wolf";
    extraGroups = [ "wheel" "video" "audio" "lp" "scanner"];
    initialPassword = "password";
    # shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    _1password-gui
    alacritty
    beekeeper-studio
    insomnia
    lazygit
    libreoffice
    mongodb-compass
    neovim
    signal-desktop
    teams
    vscode-with-extensions

    aspell
    aspellDicts.uk
    fontmatrix
    git
    jq
    maim	# Screenshot utility
    nano	# Text editor
    nnn		# Terminal file manager
    ranger	# VIM-inspired terminal file manager
    tree	# Directory listing
    unzip
    wget
    zathura
    zip

    bashmount	# bash script for managing removable media with udisks
    iwgtk	# graphical wifi management utility
    pavucontrol	# volume control
    udisks	# External drive manipulation
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      # Custom
      dbus-sway-environment
      configure-gtk

      # Sway-Related
      swaylock		# Screen lock utility
      swayidle		# Idle management daemon for Wayland
      wlogout		# Wayland-based logout menu

      # Waybar
      waybar
      libappindicator-gtk3

      # Gnome
      glib				# gsettings
      dracula-theme			# gtk theme
      gnome3.adwaita-icon-theme		# default gnome cursors

      # Helper utilities
      wl-clipboard	# Command line clipboard for Wayland
      mako		# Lightweight Wayland notifications daemon
      light		# Backlight (and other hardware lights) control
      grim		# Image grabber
      slurp		# Select area in a Wayland compositor (used for screenshots with grim)
      fuzzel		# Application launcher

      # Applications
      firefox-wayland
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    gtkUsePortal = true;
  };

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "Inconsolata"
          "InconsolataLGC"
          "JetBrainsMono"
          "RobotoMono"
        ];
      })
      source-code-pro
      source-sans-pro
      source-serif-pro
      noto-fonts-emoji
      roboto
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [ "Inconsolata" ];
        sansSerif = [ "Source Sans Pro" ];
        serif = [ "Source Serif Pro" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable the use of light for screen brightness
  programs.light.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
