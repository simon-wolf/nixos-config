#
# Home-manager config for starlite2
#

{ pkgs, ... }:

{
  imports = [
    #../../modules/desktop/sway/home.nix	# Window manager
  ];

  home = {
    packages = with pkgs; [
      firefox-wayland
    ];
  };
}
