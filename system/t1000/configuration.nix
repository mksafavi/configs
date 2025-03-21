{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ../base/nix-configuration.nix
    ./networking.nix
    ./audio.nix
    ./virtualization.nix
    ../base/desktop.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Asia/Tehran";

  i18n.defaultLocale = "en_US.UTF-8";

  services.flatpak.enable = true;

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
  systemd.packages = with pkgs; [ lact ];

  system.stateVersion = "23.11"; # Don't touch this. Do you remeber the Comment that you read?
}
