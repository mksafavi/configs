{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options = {
    services.flake-build = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = lib.mdDoc ''
          auto build flake in the background
        '';
      };
      flake = mkOption {
        type = types.str;
        description = lib.mdDoc "flake path to build";
      };
    };
  };

  config =
    let
      cfg = config.services.flake-build;
      flake = toString cfg.flake;
    in
    mkIf cfg.enable {
      systemd.packages = [ pkgs.nix-fast-build ];

      systemd.timers.flake-build = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "*-*-* 00:00:00";
          Unit = config.systemd.services.flake-build.name; # "flake-build.service";
        };
      };

      systemd.services.flake-build = {
        wantedBy = [ "multi-user.target" ];
        description = "build flake";
        serviceConfig = {
          ExecStart = "${pkgs.nix-fast-build}/bin/nix-fast-build --flake ${flake} --no-nom";
        };
      };
    };
}
