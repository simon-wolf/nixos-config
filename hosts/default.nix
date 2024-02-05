#
# These are the profiles for the different NixOS builds
#
# flake.nix
#   ./hosts
#      default.nix
#      configuration.nix
#      home.nix
#         ./starlite2 OR ./starlite4 OR ./desktop
#            ./default.nix
#            ./home.nix
#

{ lib, inputs, nixpkgs, home-manager, system, user, location, ... }:

let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  starlite4 = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      ./starlite4
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [(./home.nix)] ++ [(import ./starlite4/home.nix)];
        };
      }
    ];
  };

  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      ./desktop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [(./home.nix)] ++ [(import ./desktop/home.nix)];
        };
      }
    ];
  };

}
