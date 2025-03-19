{ pkgs, ... }:
{
  imports = [
    ../services/openrgb.nix
  ];

  boot.initrd.kernelModules = [
    "amdgpu" # load amdgpu module early.
    "v4l2loopback" # load v4l2loopback for virtual video devices
  ];
  boot.extraModulePackages = [ pkgs.linuxPackages_latest.v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback video_nr=4 exclusive_caps=1
  '';

  services.openrgb = {
    enable = true;
    profile = "off";
  };

  hardware.new-lg4ff.enable = true; # Enable LogiTech G29 support

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      amdvlk # unfree alternative to RadV vulkan loader
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk # unfree alternative to RadV vulkan loader
    ];
  };

  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true; # enables Bluetooth battery report
    powerOnBoot = true;
  };

  environment.systemPackages = with pkgs; [
    lact # TODO: add the config file generated by lact here to lock the vram clock
  ];

}
