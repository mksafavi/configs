{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ../base/nix-configuration.nix
    ../base/desktop.nix
    ./audio.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Asia/Tehran";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.home = {
    isNormalUser = true;
    description = "home";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "home";

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  system.stateVersion = "23.11"; # Don't touch this. Do you remeber the Comment that you read?
}
