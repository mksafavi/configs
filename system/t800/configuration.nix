{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ./networking.nix
    ./audio.nix
  ];

  modules.desktop.kde.enable = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.tmp.useTmpfs = true;

  time.timeZone = "Asia/Tehran";

  i18n.defaultLocale = "en_US.UTF-8";

  home-manager.users.home = import ./home.nix;
  users.users.home = {
    isNormalUser = true;
    description = "home";
    extraGroups = [
      "networkmanager"
      "wheel"
      "i2c"
    ];
  };
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "home";

  system.stateVersion = "23.11"; # Don't touch this. Do you remember the Comment that you read?
}
