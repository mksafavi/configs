{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    homeModules.music = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether to enable music production tools
        '';
      };
    };
  };
  config = lib.mkIf config.homeModules.music.enable {
    home.packages = with pkgs; [
      yabridge
      yabridgectl
      reaper
      helvum
      noise-repellent
    ];

    xdg.configFile."REAPER" = {
      source = pkgs.symlinkJoin {
        name = "reaper-userplugins";
        paths = with pkgs; [
          reaper-sws-extension
          reaper-reapack-extension
        ];
      };
      recursive = true;
    };
  };
}
