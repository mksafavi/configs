{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {

    services.openrgb = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether to run OpenRGB
        '';
      };

      profile = lib.mkOption {
        type = lib.types.str;
        description = lib.mdDoc "OpenRGB profile to apply. Use the OpenRGB Gui to create the profiles";
      };
    };
  };

  config =
    let
      cfg = config.services.openrgb;
      profile = toString cfg.profile;
    in
    lib.mkIf cfg.enable {
      systemd.packages = [ pkgs.openrgb ];
      hardware.i2c.enable = true; # for ram rgb control

      systemd.user.services.openrgb = {
        wantedBy = [ "default.target" ];
        description = "set OpenRGB profile";
        serviceConfig = {
          ExecStart = "${pkgs.openrgb}/bin/openrgb -p ${profile}";
          Type = "oneshot";
        };
      };
    };
}
