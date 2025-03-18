# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hardware.nix
    ../base/nix-configuration.nix
    ./networking.nix
    ./audio.nix
    ./virtualization.nix
    ../base/desktop.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  # Set your time zone.
  time.timeZone = "Asia/Tehran";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.flatpak.enable = true;

  fonts.packages = with pkgs; [
    wqy_zenhei
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
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
  # added user to trusted users
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  programs.gphoto2.enable = true;
  systemd.packages = with pkgs; [ lact ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
