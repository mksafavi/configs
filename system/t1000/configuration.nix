# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./networking.nix
    ./audio.nix
    ./virtualization.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # load amdgpu module early. load v4l2loopback for virtual video devices
  boot.initrd.kernelModules = [
    "amdgpu"
    "v4l2loopback"
  ];
  boot.extraModulePackages = [ pkgs.linuxPackages_latest.v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback video_nr=10 exclusive_caps=1
  '';

  # Set your time zone.
  time.timeZone = "Asia/Tehran";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.i2c.enable = true;
  hardware.new-lg4ff.enable = true;
  hardware.graphics = {
    enable32Bit = true; # For 32 bit applications
    extraPackages = with pkgs; [
      amdvlk # unfree alternative to RadV vulkan loader
    ];
    # For 32 bit applications
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk # unfree alternative to RadV vulkan loader
    ];
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.settings.General.Experimental = true; # enables Bluetooth battery report
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing = {
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
    enable = true;
    drivers = [ pkgs.splix ];
  };
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
      "libvirtd"
      "camera"
      "docker"
    ];
    packages = with pkgs; [
      kdePackages.kamera
      gphoto2fs
    ];
  };
  # added user to trusted users
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    lact # TODO: add the config file generated by lact here to lock the vram clock
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
