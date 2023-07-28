#
# Sway configuration
#

{ config, lib, pkgs, ... }:

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
in
{
  # List packages installed in system profile. To search, run:
  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec sway
      fi
    '';
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        # Custom
        dbus-sway-environment
        configure-gtk

        # Sway-Related
        swaylock			# Screen lock utility
        swayidle			# Idle management daemon for Wayland
        wlogout				# Wayland-based logout menu

        # Waybar
        waybar
        libappindicator-gtk3

        # Gnome
        glib				# gsettings
        dracula-theme			# gtk theme
        gnome3.adwaita-icon-theme	# default gnome cursors

        # Helper utilities
        wl-clipboard			# Command line clipboard for Wayland
        mako				# Lightweight Wayland notifications daemon
        light				# Backlight (and other hardware lights) control
        grim				# Image grabber
        slurp				# Select area in a Wayland compositor (used for screenshots with grim)
        fuzzel				# Application launcher
      ];
    };
  };

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
