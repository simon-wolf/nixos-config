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
      # firefox-wayland
    ];
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
