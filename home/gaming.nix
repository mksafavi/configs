{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (lutris.override {
      extraPkgs = pkgs: [
        wineWowPackages.stable
        gamescope
      ];
    })
    umu-launcher
    vulkan-tools
    steam
    oversteer
    mangohud
    yuzu
    rpcs3
    ryujinx
    duckstation
    pcsx2
  ];
}
