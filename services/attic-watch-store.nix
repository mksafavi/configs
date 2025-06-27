{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options = {
    services.attic-watch-store = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = lib.mdDoc ''
          Enable Attic watch store to automatically push to cache
        '';
      };
      cache = mkOption {
        type = types.str;
        default = "main";
        description = lib.mdDoc "cache name";
      };
    };
  };

  config =
    let
      cfg = config.services.attic-watch-store;
      cache = toString cfg.cache;
    in
    mkIf cfg.enable {
      systemd.packages = [ pkgs.attic-client ];
      systemd.services.attic-watch-store = {
        wantedBy = [ "multi-user.target" ];
        description = "Attic watch store";
        serviceConfig = {
          ExecStart = "${pkgs.attic-client}/bin/attic watch-store ${cache}";
          Restart = "on-failure";
        };
      };
    };
}
