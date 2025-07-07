#
# System configuration for thinkpad
#

{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++		# Current hardware config
    [(import ../../modules/desktop/sway/sway.nix)];	# Window manager

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  console.earlySetup = true;  # Use larger font during boot

  console = {
    packages = with pkgs; [ terminus_font ];
    font = "ter-i32b";
    keyMap = "uk";
  };

  programs = {
    #dconf.enable = true;
    light.enable = true;
  };
}
