{ config, pkgs, ... }:

{
  home.username = "simon";
  home.homeDirectory = "/home/simon";

  home.stateVersion = "22.05";

  programs.home-manager.enable = true;

  #home.packages = with pkgs; [ htop ];

  programs.git = {
    enable = true;
    userName = "Simon Wolf";
    userEmail = "swolf@fastmail.co.uk";
  };
  
  home.file.".config/alacritty" = {
    source = ./config/alacritty;
    recursive = true;
  };
}
