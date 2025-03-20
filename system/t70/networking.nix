{ config, pkgs, ... }:
{

  imports = [
    ../base/networking.nix
  ];

  networking.hostName = "t70";

  networking.interfaces.enp5s0.wakeOnLan.enable = true;

  services.atticd = {
    enable = true;
    environmentFile = "/home/s/.config/attic/env";
    settings = {
      listen = "[::]:8080";

      jwt = { };
    };
  };

  services.aria2 = {
    enable = true;
    rpcSecretFile = "/var/lib/aria2/aria2-rpc-token";
    settings =
      let
        session-path = "/var/lib/aria2/aria2.session";
      in
      {
        continue = true;
        max-connection-per-server = 5;
        save-session = session-path;
        input-file = session-path;
        save-session-interval = 10;
        listen-port = [ ];
        rpc-listen-port = 6800;
      };
  };

  services.caddy = {
    enable = true;

    virtualHosts."http://${config.networking.hostName}.lan" = {
      extraConfig = ''
        handle_path /ariang* {
          root * ${pkgs.ariang}/share/ariang
          file_server
        }
        handle_path /aria2* {
          reverse_proxy http://localhost:${toString config.services.aria2.settings.rpc-listen-port}
        }
      '';
    };
  };

  services.zerotierone.enable = true;

  networking.firewall.allowedTCPPorts = [
    8080 # atticd
    80 # caddy
  ];
}
