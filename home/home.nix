{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    vim
    wget
    lf
firefox
git
  ];
  home.username = "home";
  home.homeDirectory = "/home/home";
  home.stateVersion = "23.11";
}
