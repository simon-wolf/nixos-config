#
# System configuration for starlite2
#

{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++		# Current hardware config
    [(import ../../modules/desktop/sway/sway.nix)];	# Window manager

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  console.earlySetup = true;  # Use larger font during boot

  programs = {
    #dconf.enable = true;
    light.enable = true;
  };
}
