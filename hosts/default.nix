#
# These are the profiles for the different NixOS builds
#
# flake.nix
#   ./hosts
#      configuration.nix
#      default.nix
#      ./desktop OR ./starlite4 OR ./thinkpad
#        ./default.nix
#        ./hardware-configuration.nix
#      home.nix
#      ./home
#        ...
#

{ lib, inputs, nixpkgs, home-manager, system, user, location, ... }:

let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;

  shared-modules = ([
    ./configuration.nix
    ../modules/sway.nix
    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {
        inherit user;
      };
      home-manager.users.${user} = {
        imports = [
          ./home.nix
        ];
      };
    }
  ]);
in
{
  starlite4 = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      ./starlite4
    ] ++ shared-modules;
  };

  thinkpad = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      ./thinkpad
    ] ++ shared-modules;
  };

  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      ./desktop
    ] ++ shared-modules;
  };
}
