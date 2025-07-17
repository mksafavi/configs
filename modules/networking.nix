{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {

    modules.networking = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether to enable networking
        '';
      };

      hostName = lib.mkOption {
        type = lib.types.str;
        description = lib.mdDoc ''
          System host name
        '';
      };

      firewall.allowedTCPPorts = lib.mkOption {
        type = lib.types.listOf lib.types.port;
        default = [ ];
        description = lib.mdDoc ''
          allowed tcp ports in firewall
        '';
      };

      firewall.allowedUDPPorts = lib.mkOption {
        type = lib.types.listOf lib.types.port;
        default = [ ];
        description = lib.mdDoc ''
          allowed udp ports in firewall
        '';
      };

    };
  };

  config =
    let
      cfg = config.modules.networking;
    in
    lib.mkIf cfg.enable {

      networking.hostName = cfg.hostName;

      services = {
        xray = {
          enable = true;
          settingsFile = "/etc/xray/config.json";
        };

        attic-watch-store = {
          enable = true;
        };
      };

      services.openssh.enable = true;

      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
        publish = {
          enable = true;
          userServices = true;
        };
      };

      services.printing = {
        listenAddresses = [ "*:631" ];
        allowFrom = [ "all" ];
        browsing = true;
        defaultShared = true;
        openFirewall = true;
        enable = true;
        drivers = [
          pkgs.splix # Samsung printer driver
        ];
      };

      networking.networkmanager.enable = true;

      programs.bandwhich.enable = true;

      networking.firewall.enable = true;

      networking.firewall.allowedTCPPorts = cfg.firewall.allowedTCPPorts;
      networking.firewall.allowedUDPPorts = cfg.firewall.allowedUDPPorts;
    };
}
