{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ./networking.nix
    ./audio.nix
    ./virtualization.nix
  ];

  modules.desktop.kde.enable = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.tmp.useTmpfs = true;

  time.timeZone = "Asia/Tehran";

  i18n.defaultLocale = "en_US.UTF-8";

  services.flatpak.enable = true;

  home-manager.users.mk = import ./mk.nix;
  users.users.mk = {
    isNormalUser = true;
    description = "mk";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "audio"
      "docker"
      "i2c"
    ];
    packages = with pkgs; [
      attic-client
    ];
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  system.stateVersion = "23.11"; # Don't touch this. Do you remember the Comment that you read?
}
