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

  systemd.network.enable = true;


  services.resolved.settings.Resolve = {
    DNSStubListenerExtra = "10.0.0.1";
  };

  networking.networkmanager.unmanaged = [ "br-microvm" ];

  systemd.network.netdevs."br-microvm" = {
    netdevConfig = {
      Name = "br-microvm";
      Kind = "bridge";
    };
  };

  systemd.network.networks."10-br-microvm" = {
    matchConfig.Name = "br-microvm";
    networkConfig = {
      Address = [ "10.0.0.1/24" ];
      IPMasquerade = "ipv4";
      ConfigureWithoutCarrier = true;
    };
  };

  systemd.network.networks."10-vm-tap" = {
    matchConfig.Name = "vm-*";
    networkConfig.Bridge = "br-microvm";
  };
}
