{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    vim
    wget
    lf
firefox
git
lutris
wine
telegram-desktop
qv2ray
  ];
  home.username = "mk";
  home.homeDirectory = "/home/mk";
  home.stateVersion = "23.11";
}
