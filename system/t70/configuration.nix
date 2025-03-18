{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../base/nix-configuration.nix
    ./networking.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/disk/by-id/ata-CT240BX500SSD1_2143E5DE2944";
  boot.loader.grub.useOSProber = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.nvidiaOptimus.disable = true; # disable nvidia gpu

  time.timeZone = "Asia/Tehran";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.s = {
    isNormalUser = true;
    description = "s";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      attic-client
    ];
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  services.logind.lidSwitch = "ignore";

  system.stateVersion = "24.11"; # Don't touch this. Do you remeber the Comment that you read?
}
