#
# System configuration for Hades Canyon desktop
#

{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++		# Current hardware config
    [(import ../../modules/desktop/sway/sway.nix)];	# Window manager

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  console = {
    packages = with pkgs; [ terminus_font ];
    font = "Lat2-Terminus16";
    earlySetup = true;
    keyMap = "us";
  };

  programs = {
    #dconf.enable = true;
    light.enable = true;
  };
  
  fileSystems."/mnt/pi-nas/shared" = {
    device = "//192.168.10.2/shared";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
	
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };

  fileSystems."/mnt/pi-nas/media" = {
    device = "//192.168.10.2/media";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
	
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };

  # Udev rules for ZSA/Wally to flash Ergodox keyboard
  # https://github.com/zsa/wally/wiki/Linux-install
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "wally_udev";
      text = ''
        # Wally Flashing rules for the Ergodox EZ
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
        KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

        # Wally Flashing rules for the Moonlander and Planck EZ
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", \
            MODE:="0666", \
            SYMLINK+="stm32_dfu"
      '';
      destination = "/etc/udev/rules.d/50-zsa.rules";
    })
  ];
}
