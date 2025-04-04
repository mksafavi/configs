{ config, pkgs, ... }:
{
  #home tv pc configurations
  imports = [
    ../../home/gc.nix
    ../../home/fish.nix
    ../../home/network.nix
    ../../home/internet.nix
    ../../home/utils.nix
    ../../home/media.nix
    ../../home/gaming.nix
  ];
  home.username = "home";
  home.homeDirectory = "/home/home";
  home.stateVersion = "23.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    fjordlauncher
  ];
}
