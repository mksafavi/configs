{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    lf
    vim
    jq
    bc
    usbutils
    iotop
    btop
    ncdu
    htop
    unrar
    p7zip
    lsof
    jcal
    file
  ];
}
