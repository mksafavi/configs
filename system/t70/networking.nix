{
  config,
  pkgs,
  lib,
  ...
}:
{
  modules.networking = {
    enable = true;
    hostName = "t70";
    firewall.allowedTCPPorts =
      [
        8080 # atticd
        80 # caddy
      ]
      ++ [
        20170 # proxy
      ];
  };

  networking.interfaces.enp5s0.wakeOnLan.enable = true;

  services.atticd = {
    enable = true;
    environmentFile = "/home/s/.config/attic/env";
    settings = {
      listen = "[::]:8080";

      jwt = { };
    };
  };

  services.lms = {
    enable = true;
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
    downloadDirPermission = "0777";
    serviceUMask = "0002";
  };

  services.timetagger = {
    enable = true;
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

        handle_path  /lms* {
          reverse_proxy http://localhost:5082
        }

        handle  /timetagger* {
          reverse_proxy http://localhost:8082
        }
      '';
    };
  };

  services.samba = {
    enable = true;
    openFirewall = true;

    settings =
      {
        global = {
          "vfs objects" = "recycle";
          "recycle:repository" = ".recycle";
          "recycle:keeptree" = "yes";
          "recycle:versions" = "yes";
          "wide links" = "yes";
          "allow insecure wide links" = "yes";
        };
        public = {
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          path = "/mnt/storage/public";
        };
      }
      // lib.attrsets.genAttrs [ "mk" "marsami" "arani" "anna" ] (name: {
        browseable = "yes";
        "read only" = "no";
        "valid users" = name;
        path = "/mnt/storage/${name}";
      });

  };
}
