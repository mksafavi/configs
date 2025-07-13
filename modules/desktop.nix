{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    modules.desktop.kde = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether to enable kde plasma desktop
        '';
      };
    };
  };

  config =
    let
      cfg = config.modules.desktop;
    in
    lib.mkIf cfg.kde.enable {
      services.displayManager.sddm.enable = true;
      services.displayManager.sddm.wayland.enable = true;
      services.displayManager.defaultSession = "plasma";
      services.desktopManager.plasma6.enable = true;
      services.speechd.enable = false;
      services.orca.enable = false;

      # Configure keymap in X11
      services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";
      };

    };
}
