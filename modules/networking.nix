{ config, pkgs, ... }:
{

  imports = [
    ../services/attic-watch-store.nix
  ];

  services = {
    xray = {
      enable = true;
      settingsFile = "/etc/xray/config.json";
    };

    attic-watch-store = {
      enable = true;
    };
  };

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

  networking.networkmanager.enable = true;

  programs.bandwhich.enable = true;

  networking.firewall.enable = true;
}
