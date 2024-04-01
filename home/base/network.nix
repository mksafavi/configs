{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    wget
    firefox
    chromium
    telegram-desktop
    nethogs
    nload
  ];
}
