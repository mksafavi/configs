{ config, pkgs, ... }:
{
  homeModules.internet.enable = true;
  homeModules.media.enable = true;
  homeModules.gaming.enable = true;

  home.username = "home";
  home.homeDirectory = "/home/home";
  home.stateVersion = "23.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    fjordlauncher
# TODO:  remove this and add a desktop icon to a local flake on ~/games/minecraft
  ];
}
