{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox
    chromium
    telegram-desktop
    localsend
    authenticator
    turnon
  ];
}
