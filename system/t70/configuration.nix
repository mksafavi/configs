{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./virtualization.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/disk/by-id/ata-CT240BX500SSD1_2143E5DE2944";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.tmp.useTmpfs = true;

  hardware.nvidiaOptimus.disable = true; # disable nvidia gpu

  time.timeZone = "Asia/Tehran";

  i18n.defaultLocale = "en_US.UTF-8";

  home-manager.users.s = import ./s.nix;
  users.users.s = {
    isNormalUser = true;
    description = "s";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      attic-client
    ];
  };

  home-manager.users.anna = import ./anna.nix;
  users.users.anna = {
    isNormalUser = true;
    description = "anna";
    extraGroups = [
      "networkmanager"
      "docker"
    ];
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  services.logind.lidSwitch = "ignore";

  system.stateVersion = "24.11"; # Don't touch this. Do you remeber the Comment that you read?
}
