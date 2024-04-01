{ config, lib, pkgs, ... }:

with lib;

{
  options = {

    services.xray-proxy = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether to run xray proxy
        '';
      };

      package = mkOption {
        type = types.package;
        default = pkgs.xray;
        defaultText = literalExpression "pkgs.xray";
        description = lib.mdDoc ''
          Which xray package to use.
        '';
      };

      configFile = mkOption {
        type = types.str;
        default = "config.json";
        description = lib.mdDoc "xray config json path";
      };
    };

  };

  config = let
    cfg = config.services.xray-proxy;
    configFile = toString cfg.configFile;
    cli = "${cfg.package}/bin/xray";

  in mkIf cfg.enable {
    systemd.packages = [ cfg.package ];

    systemd.user.services.xray-proxy = {
      wantedBy = [ "multi-user.target" ];
      description = "Connect to xray proxy";
      script = ''
        ${cli} -c ${configFile}
      '';

    };
  };
}
