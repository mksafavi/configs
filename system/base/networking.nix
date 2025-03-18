{ config, pkgs, ... }:
{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  # Enable CUPS to print documents.
  services.printing = {
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
    enable = true;
    drivers = [
      pkgs.splix # Samsung printer driver
    ];
  };

  # Enable networking
  networking.networkmanager.enable = true;

  programs.bandwhich.enable = true;

  networking.firewall.enable = true;
}
