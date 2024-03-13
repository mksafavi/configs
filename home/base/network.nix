{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    wget
    firefox
    chromium
    qv2ray
    telegram-desktop
    nethogs
    nload
  ];
}
