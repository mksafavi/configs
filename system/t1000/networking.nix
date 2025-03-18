{ config, pkgs, lib, ... }:
{

  imports = [
    ../base/networking.nix
  ];

  networking.hostName = "t1000";

  networking.firewall.allowedTCPPorts = [
    1716 # kdeconnect
    53317 # localsend
    9090 # calibre
  ];
  networking.firewall.allowedUDPPorts = [
    1716 # kdeconnect
    53317 # localsend
  ];
  networking.interfaces.enp14s0.wakeOnLan.enable = true;

  users.users.mk = {
    packages = with pkgs; [
      zerotierone
    ];
  };
}
