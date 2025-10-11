{ config, ... }:
{

  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11_beta ];

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
    nvidiaPersistenced = true; # to enable gpu in headless mode

    powerManagement.enable = true;
    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  hardware.logitech.wireless = {
    enable = true; # Enable logitech k400 support
    enableGraphical = true;
  };

  hardware.new-lg4ff.enable = true; # Enable LogiTech G29 support
}
