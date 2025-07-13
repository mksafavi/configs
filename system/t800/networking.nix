{ config, pkgs, ... }:
{
  networking.hostName = "t800";

  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  networking.firewall.allowedTCPPorts = [
    1716 # kdeconnect
    53317 #localsend
  ];
  networking.firewall.allowedUDPPorts = [
    1716 # kdeconnect
    53317 #localsend
  ];
}
