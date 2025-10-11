{ config, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver = {
    enable = true; # Enable the X11 windowing system.
    videoDrivers = [ "nvidia" ]; # Load nvidia driver for Xorg and Wayland
  };

  hardware.nvidia = {
    modesetting.enable = true; # Modesetting is required.
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
  };
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  hardware.logitech.wireless = {
    enable = true; # Enable logitech k400 support
    enableGraphical = true;
  };

  hardware.new-lg4ff.enable = true; # Enable LogiTech G29 support
}
