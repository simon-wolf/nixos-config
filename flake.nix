{
  description = "Simon Wolf's NixOS and Home-Manager Configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      # url = "github:nix-community/home-manager/release-25.11";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # dms = {
    #   url = "github:AvengeMedia/DankMaterialShell/stable";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # niri-stable = {
    #   url = "github:YaLTeR/niri/v25.08";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    xwayland-satellite-stable = {
      url = "github:Supreeeme/xwayland-satellite/v0.7";
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
