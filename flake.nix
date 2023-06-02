{
  description = "Simon Wolf's NixOS and Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      user = "simon";
      location = "$HOME/.nixos-setup";
    in {
      nixosConfigurations = (
        import ./hosts {				# Imports ./hosts/default.nix
          inherit (nixpkgs) lib;			# Import lib from nixpkgs
	  inherit inputs nixpkgs home-manager system user location;	# Inherit home-manager so that it does not need to be redefined
	}
      );
    };
}
