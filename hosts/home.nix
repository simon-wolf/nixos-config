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
      fzf                   # Fuzzy find
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

      # Email
      neomutt               # Email
      isync                 # Mail download and local sync (mbsync)
      msmtp                 # Send outgoing email via SMTP
      pass                  # To encrypt credentials
      pam_gnupg             # PAM module to hand login password to gpg-agent
      lynx                  # Command-line browser to view HTML emails
      abook                 # Command-line address book
      notmuch-mutt          # Index and search mail
      gnupg                 # Crypto
      gpg-tui               # Terminal interface for GnuPG
      pinentry-curses       # GnuPG's interface to passphrase input

      # Audio & Video
      abcde                 # CD Ripper
      cdparanoia            # Reads digital audio from CDs (for abcde)
      feh                   # Image Viewer
      flac                  # FLAC audio format library and tools (for abcde)
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
      beekeeper-studio
      chromium
      firefox 
      gnome.gnome-disk-utility
      gnome-obfuscate       # Censor private information in images
      gnome.simple-scan
      gnome-text-editor
      libreoffice-fresh
      mongodb-compass
      maestral              # Dropbox
      maestral-gui
      ngrok
      obsidian
      pdfarranger
      signal-desktop
      slack
      tdesktop              # Telegram
      # teams
      thunderbird

      # LaTeX
      texlive.combined.scheme-full
      texstudio

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
#    tmux = {
#      enable = true;
#      shortcut = "a";
#      baseIndex = 1;
#      clock24 = true;
#      keyMode = "vi";
#      escapeTime = 1;
#      terminal = "screen-256color";
#      extraConfig = ''
#        # Use v and b to split vertically and horizontally (matching Sway)
#        unbind v
#	unbind b
#        unbind % # Split vertically
#	unbind '"' # Split horizontally
#
#	bind v split-window -v -c "#{pane_current_path}"
#	bind b split-window -h -c "#{pane_current_path}"
#      '';
#    };
    neomutt = {
      enable = true;
      vimKeys = false;
      sidebar = {
        enable = true;
	format = "%B%?F? [%F]?%* %?N?%N/?%S";
	shortPath = true;
      };
      sort = "reverse-date-received";
      extraConfig = ''
	# cache settings
	set header_cache = "~/mail/fastmail/cache/headers"
	set message_cachedir = "~/mail/fastmail/cache/bodies"
        
	# navigation settings

	# synchronisation settings
	macro index S "<shell-escape>mbsync -V fastmail<enter>" "sync email"

	# misc settings
        set mail_check_stats

	# default index colour settings
	color index yellow default ".*"
	color index_author red default ".*"
        color index_number blue default ".*"
        color index_subject cyan default ".*"

        # new mail colour settings
        color index brightyellow black "~N"
        color index_author brightred black "~N"
        color index_subject brightcyan black "~N"
      '';
    };
  };

  accounts = {
    email = {
      maildirBasePath = "mail";
      accounts.fastmail = {
        primary = true;
	realName = "Simon Wolf";
	flavor = "fastmail.com";
        userName = "swolf@fastmail.co.uk";
        passwordCommand = "pass Personal/Fastmail";
        address = "swolf@fastmail.co.uk";
	maildir = {
	  path = "fastmail";
	};
	folders = {
          inbox = "INBOX";
	  drafts = "Drafts";
	  sent = "Sent Items";
	  trash = "Trash";
	};
	msmtp = {
	  enable = true;
	};
	neomutt = {
          enable = true;
	  sendMailCommand = "msmtp -a fastmail";
	};
      };
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableScDaemon = false;
  };
  programs.gpg.enable = true;

#  systemd.timers = "mbsync-mail-refresh" = {
#    wantedBy = [ "timers.target" ];
#    timerConfig = {
#      OnBootSec = "1m";
#      OnUnitActiveSec = "5m";
#      Unit = "mbsync.service";
#    };
#  };

#  systemd.services."mbsync-mail-refresh" = {
#    script = ''
#      set -eu
#      ${pkgs.coreutils}/bin/mbsync "fastmail"
#    '';
#    serviceConfig = {
#      Type = "oneshot";
#      User = "simon";
#    };
#  };

  home.file.".abcde.conf" = {
    source = ../config/abcde/abcde_lossless_flac.conf;
    recursive = false;
  };

  home.file.".config/alacritty" = {
    source = ../config/alacritty;
    recursive = true;
  };

  home.file.".mbsyncrc" = {
    source = ../config/neomutt/mbsync.conf;
    recursive = false;
  };
  home.file.".notmuch-config" = {
    source = ../config/neomutt/notmuch.conf;
    recursive = false;
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
