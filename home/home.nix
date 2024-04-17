{ config, pkgs, ... }:
{
  #home tv pc configurations
  imports = [
    ./base/network.nix
    ./base/utils.nix
    ./base/media.nix
    ./base/gaming.nix
  ];
  home.username = "home";
  home.homeDirectory = "/home/home";
  home.stateVersion = "23.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [ ];
}
