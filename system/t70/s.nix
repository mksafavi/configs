{ config, pkgs, ... }:
{
  homeModules.gc.enable = false;

  home.username = "s";
  home.homeDirectory = "/home/s";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
  ];
}
