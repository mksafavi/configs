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

  services.zerotierone.enable = true;

  networking.firewall.allowedTCPPorts = [
    8080 # atticd
  ];
}
