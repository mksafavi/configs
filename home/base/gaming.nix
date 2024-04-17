{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (lutris.override { extraPkgs = pkgs: [ wineWowPackages.stable ]; })
    mangohud
    yuzu
    rpcs3
    ryujinx
  ];
}
