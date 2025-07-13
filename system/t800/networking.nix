{ config, pkgs, ... }:
{

  modules.networking = {
    enable = true;
    hostName = "t800";
    firewall.allowedTCPPorts = [
      1716 # kdeconnect
      53317 # localsend
    ];
    firewall.allowedUDPPorts = [
      1716 # kdeconnect
      53317 # localsend
    ];
  };

  networking.interfaces.enp3s0.wakeOnLan.enable = true;
}
