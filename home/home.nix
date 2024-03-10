{ config, pkgs, ... }: {
  home.username = "home";
  home.homeDirectory = "/home/home";
  home.stateVersion = "23.11";
  services.kdeconnect.enable = true;
  home.packages = with pkgs; [
    vim
    wget
    lf
    firefox
    qv2ray
    chromium
    lutris
    wineWowPackages.stable
    mangohud
    telegram-desktop
    maliit-keyboard
    usbutils
    iotop
    btop
    ncdu
    nethogs
  ];

}
