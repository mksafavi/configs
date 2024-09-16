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
    steam
    oversteer
    mangohud
    yuzu
    rpcs3
    ryujinx
  ];
}
