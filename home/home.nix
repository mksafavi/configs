{ config, pkgs, ... }:
{
  #home tv pc configurations
  imports = [
    ./base/gc.nix
    ./base/fish.nix
    ./base/network.nix
    ./base/internet.nix
    ./base/utils.nix
    ./base/media.nix
    ./base/gaming.nix
  ];
  home.username = "home";
  home.homeDirectory = "/home/home";
  home.stateVersion = "23.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    fjordlauncher
  ];
}
