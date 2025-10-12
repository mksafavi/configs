{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    homeModules.gaming = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether to enable gaming apps
        '';
      };
    };
  };
  config = lib.mkIf config.homeModules.gaming.enable {
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
      rpcs3
      ryubing
      duckstation
      pcsx2
    ];
  };
}
