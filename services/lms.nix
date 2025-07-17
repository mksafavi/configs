{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    services.lms = {
      enable = lib.mkEnableOption "Lightweight Music Server";

      package = lib.mkPackageOption pkgs "lms" { };

      settings = lib.mkOption {
        type = lib.types.submodule {
          options = {
            listen-addr = lib.mkOption {
              default = "127.0.0.1";
              type = lib.types.str;
            };

            listen-port = lib.mkOption {
              default = 5082;
              type = lib.types.port;
            };
            deploy-path = lib.mkOption {
              default = "/";
              type = lib.types.str;
            };
          };
        };
        default = { };
        #example = {
        #  MusicFolder = "/mnt/music";
        #};
        description = "LMS Configurations";
      };

      openFirewall = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to open the TCP port in the firewall";
      };
    };
  };

  config =
    let
      cfg = config.services.lms;
      generateConfig =
        name: value:
        let
          values = lib.mapAttrs (
            k: v:
            lib.pipe v [
              (v: builtins.toString v)
              (v: builtins.replaceStrings [ "/" ] [ "\\/" ] v)
            ]
          ) value;

        in
        pkgs.callPackage (
          { runCommand, jq }:
          runCommand name
            {
              preferLocalBuild = true;
            }
            ''
              cat ${pkgs.lms}/share/lms/lms.conf > lms.conf
              ${lib.concatStringsSep "\n" (
                lib.mapAttrsToList (k: v: ''
                  sed --in-place -E 's/(${k} = )(")?[a-zA-Z0-9/.]*(")?;/\1\2${builtins.toString v}\3;/' lms.conf
                '') values
              )}
              cp lms.conf $out
            ''
        ) { };
    in
    lib.mkIf cfg.enable rec {

      users.groups.lms = { };
      users.users.lms = {
        group = config.users.groups.lms.name;
        isSystemUser = true;
        createHome = true;
        home = "/var/lms";
      };
      systemd.packages = with pkgs; [ lms ];
      systemd.services.lms = {
        enable = true;
        wantedBy = [ "multi-user.target" ];
        script = ''
          id
          ${pkgs.lms}/bin/lms ${generateConfig "lms.conf" cfg.settings}
        '';
        serviceConfig = {
          User = config.users.users.lms.name;
          Group = config.users.groups.lms.name;
        };
      };
      #networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [ 5082 ]; # cfg.settings.Port ];
    };
  meta.maintainers = with lib.maintainers; [ mksafavi ];
}
