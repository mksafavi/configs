{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    lf
    vim
    python3
    jq
    bc
    usbutils
    iotop
    btop
    ncdu
    htop
    rar
    p7zip
    unzip
    zip
    lsof
    jcal
    file
    qrrs
    moreutils
    pwgen
    nix-profile-diff
    termdown
  ];
}
