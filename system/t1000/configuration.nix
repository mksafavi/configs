{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ../../modules/nix-configuration.nix
    ./networking.nix
    ./audio.nix
    ./virtualization.nix
    ../../modules/desktop.nix
  ];

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
      "camera"
      "docker"
    ];
    packages = with pkgs; [
      kdePackages.kamera
      gphoto2fs
      attic-client
    ];
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  programs.gphoto2.enable = true;

  system.stateVersion = "23.11"; # Don't touch this. Do you remeber the Comment that you read?
}
