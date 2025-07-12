{
  config,
  pkgs,
  lib,
  ...
}:
{

  imports = [
    ../../modules/networking.nix
  ];

  networking.hostName = "t70";

  networking.interfaces.enp5s0.wakeOnLan.enable = true;

  services.v2raya = {
    enable = true;
    cliPackage = pkgs.xray;
  };
  networking.nftables.enable = true; # needed for v2rayA tproxy

  services.atticd = {
    enable = true;
    environmentFile = "/home/s/.config/attic/env";
    settings = {
      listen = "[::]:8080";

      jwt = { };
    };
  };

  systemd.packages = with pkgs; [ lms ];
  systemd.services.lmsd = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
  };
  users.groups.lms = { };
  users.users.lms = {
    group = config.users.groups.lms.name;
    isSystemUser = true;
    createHome = true;
    home = "/var/lms";
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
      '';
    };
  };

  services.samba = {
    enable = true;
    package = pkgs.samba4Full;
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

  services.zerotierone.enable = true;

  networking.firewall.allowedTCPPorts =
    [
      8080 # atticd
      80 # caddy
    ]
    ++ [
      # v2raya
      2017
      20170
      20171
      20172
    ];
}
