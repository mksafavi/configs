{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (lutris.override {
      extraPkgs = pkgs: [
        wineWowPackages.stable
        gamescope
      ];
    })
    vulkan-tools
    oversteer
    mangohud
    yuzu
    rpcs3
    ryujinx
  ];
}
