{
  description = "Simon Wolf's NixOS and Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    user = "simon";
    location = "$HOME/.nixos-config";
  in {
      nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager;
          inherit system user location;
      }
    );
  };
}
