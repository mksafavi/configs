{ config, pkgs, ... }:
{

  imports = [
    ../base/networking.nix
  ];

  networking.hostName = "t800";

  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    1716 # kdeconnect
    53317 #localsend
  ];
  networking.firewall.allowedUDPPorts = [
    1716 # kdeconnect
    53317 #localsend
  ];
}
