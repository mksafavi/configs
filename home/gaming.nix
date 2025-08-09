{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    lutris
    wineWowPackages.stable
    umu-launcher
    gamescope
    vulkan-tools
    steam
    protontricks
    oversteer
    mangohud
    yuzu
    rpcs3
    ryubing
    duckstation
    pcsx2
  ];
}
