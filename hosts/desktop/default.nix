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
}
