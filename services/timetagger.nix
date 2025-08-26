{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options = {
    services.timetagger = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = lib.mdDoc ''
          Enable TimeTagger service
        '';
      };
    };
  };

  config =
    let
      cfg = config.services.timetagger;
    in
    mkIf cfg.enable {
      users.groups.timetagger = { };
      users.users.timetagger = {
        group = config.users.groups.timetagger.name;
        isSystemUser = true;
        createHome = true;
        home = "/var/timetagger";
      };
      systemd.packages = [ pkgs.timetagger ];
      systemd.services.timetagger = {
        wantedBy = [ "default.target" ];
        description = "TimeTagger server";
        serviceConfig = {
          User = config.users.users.timetagger.name;
          Group = config.users.groups.timetagger.name;
          ExecStart = "${pkgs.timetagger}/bin/timetagger --datadir ${config.users.users.timetagger.home}";
          EnvironmentFile = "${config.users.users.timetagger.home}/env";
          Restart = "on-failure";
          RestartSec = 30;
        };
      };
    };
}
