#
# Main system configuration
#

{ config, lib, pkgs, inputs, user, location, ... }:
{
  time.timeZone = "Europe/London";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
  };

  console = {
    packages = with pkgs; [ terminus_font ];
    font = "ter-i32b";
    earlySetup = true;
    keyMap = "us";
  };

  hardware =
    let
      brother = "Brother_HL-5450DN_NixOS";
      brother_ip = "192.168.10.10";
      xerox = "Xerox_Phaser_6510DN_NixOS";
      xerox_ip = "192.168.10.11";
    in
    {
      printers = {
        ensureDefaultPrinter = brother;
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # udisks2 service
  services.udisks2.enable = true;

  # Gnome keyring
  services.gnome.gnome-keyring.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = true;
    users.${user} = {
      isNormalUser = true;
      description = "Simon Wolf";
      extraGroups = [ "wheel" "video" "audio" "lp" "scanner" "plugdev" "libvirtd" "keyd" ];
      initialPassword = "password";
      shell = pkgs.zsh;
    };
  };

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [
      nano # Text editor
      wget # Retrieve files via HTTP, HTTPS & FTP
    ];
  };

  programs = {
    ssh = {
      startAgent = true; # Start OpenSSH agent at login
    };
    nix-ld = {
      enable = true; # Run unpatched dynamic libraries
    };
    zsh = {
      enable = true;
    };
    light = {
      enable = true; # Backlight
    };
  };

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      nerd-fonts.inconsolata
      nerd-fonts.inconsolata-lgc
      nerd-fonts.jetbrains-mono
      nerd-fonts.roboto-mono
      b612
      source-code-pro
      source-sans-pro
      source-serif-pro
      roboto
      merriweather
      montserrat
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      open-sans
      fira-code
      fira-code-symbols
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
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "beekeeper-studio-5.1.5"
    ];
  };

  system = {
    stateVersion = "22.05";
  };
}
