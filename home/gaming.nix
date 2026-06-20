{
  config,
  pkgs,
  lib,
  fjordlauncher,
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
      fjordlauncher = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = lib.mdDoc ''
            Whether to enable minecraft launcher
          '';
        };
      };
    };
  };
  config =
    let
      cfg = config.homeModules.gaming;
    in
    lib.mkIf cfg.enable {
      home.packages =
        with pkgs;
        [
          lutris
          wineWow64Packages.stableFull
          winetricks
          umu-launcher
          faugus-launcher
          gamescope
          vulkan-tools
          steam
          protontricks
          oversteer
          mangohud
          rpcs3
          ryubing
          pcsx2
        ]
        ++ (if cfg.fjordlauncher.enable then [ fjordlauncher.fjordlauncher ] else [ ]);
    };
}
