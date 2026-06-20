{ config, pkgs, ... }:
{
  home.username = "s";
  home.homeDirectory = "/home/s";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
  ];
}
