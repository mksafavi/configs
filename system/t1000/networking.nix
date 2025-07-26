{ config, pkgs, ... }:
{

  modules.networking = {
    enable = true;
    hostName = "t1000";
    firewall.allowedTCPPorts = [
      1716 # kdeconnect
      53317 # localsend
      9090 # calibre
    ];
    firewall.allowedUDPPorts = [
      1716 # kdeconnect
      53317 # localsend
    ];
  };

  networking.interfaces.enp14s0.wakeOnLan.enable = true;

}
