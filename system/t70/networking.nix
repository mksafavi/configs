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

  services.calibre-server = {
    enable = true;
    port = 8089;
    extraFlags = [ "--url-prefix=/calibre/server" ];
  };

  services.calibre-web = {
    enable = true;
    listen.port = 8083;

    options = {
      calibreLibrary = builtins.elemAt config.services.calibre-server.libraries 0;
      reverseProxyAuth.enable = true;
      enableBookUploading = true;
      enableBookConversion = true;
    };
    user = config.services.calibre-server.user;
    group = config.services.calibre-server.group;
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
        dir = "/mnt/storage/downloads";
      };
  };

  services.caddy = {
    enable = true;

    virtualHosts."http://${config.networking.hostName}.lan" = {
      extraConfig = ''
        handle /ariang* {
          root * ${pkgs.ariang}/share
          file_server
        }
        handle_path /aria2* {
          reverse_proxy http://localhost:${toString config.services.aria2.settings.rpc-listen-port}
        }

        handle_path /calibre/server* {
          reverse_proxy http://localhost:${toString config.services.calibre-server.port}
        }

        reverse_proxy /calibre/web* {
          to http://localhost:${toString config.services.calibre-web.listen.port}
          header_up X-Script-Name /calibre/web
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
