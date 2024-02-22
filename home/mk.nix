{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    vim
    wget
    lf
  ];
  home.username = "mk";
  home.homeDirectory = "/home/mk";
  home.stateVersion = "23.05";
}
