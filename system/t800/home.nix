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
  ];
}
