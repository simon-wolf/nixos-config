#
# Main system configuration
#

{ config, lib, pkgs, inputs, user, location, ... }:

{
  imports =
    [
    ];

  time.timeZone = "Europe/London";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware =
    let
      brother = "Brother_HL-5450DN_NixOS";
      brother_ip = "192.168.10.10";
      xerox = "Xerox_Phaser_6510DN_NixOS";
      xerox_ip = "192.168.10.11";
    in
    {
      printers = {
        # ensureDefaultPrinter = brother;
        ensurePrinters = [
          {
            name = brother;
            deviceUri = "ipp://${brother_ip}/ipp";
            model = "everywhere";
            description = lib.replaceStrings [ "_" ] [ " " ] brother;
            location = "Office";
          }
          {
            name = xerox;
            deviceUri = "ipp://${xerox_ip}/ipp";
            model = "everywhere";
            description = lib.replaceStrings [ "_" ] [ " " ] xerox;
            location = "Office";
          }
        ];
      };
      sane = {
        enable = true;
      };
    };

  # Run unpatched dynamic libraries
  programs.nix-ld.enable = true;

  # ZSH
  programs.zsh.enable = true;

  # Podman Virtualisation
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      # defaultNetwork.settings = {
      #   dns_enabled = true;
      # };
    };
  };

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # udisks2 service
  services.udisks2.enable = true;

  # Gnome keyring
  services.gnome.gnome-keyring.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = true;
  users.users.${user} = {
    isNormalUser = true;
    description = "Simon Wolf";
    extraGroups = [ "wheel" "video" "audio" "lp" "scanner" "plugdev" "libvirtd"];
    initialPassword = "password";
    shell = pkgs.zsh;
  };

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [
      nano	# Text editor
      wget      # Retrieve files via HTTP, HTTPS & FTP
    ];
  };

  # Start OpenSSH agent at login
  programs = {
    ssh = {
      startAgent = true;
    };
  };

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
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
      merriweather
      montserrat
      open-sans
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

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = lib.optional (pkgs.obsidian.version == "1.4.16") "electron-25.9.0";
  };

  system = {
    stateVersion = "22.05";
  };
}
