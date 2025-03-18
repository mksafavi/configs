{ config, ... }:
{
  hardware.graphics = { # Enable OpenGL
    enable = true;
    enable32Bit = true;
  };


  boot.initrd.kernelModules = [
    "nvidia" # Load nvidia driver early
    "nvidia_uvm"
    "nvidia_drm"
    "nvidia_modeset"
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11_beta ];

  hardware.nvidia = {

    modesetting.enable = true; # Modesetting is required.
    forceFullCompositionPipeline = true; # Fix screen tearing
    nvidiaPersistenced = true; # to enable gpu in headless mode

    powerManagement.enable = true; # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.finegrained = false; # Fine-grained power management. Turns off GPU when not in use. Experimental and only works on modern Nvidia GPUs (Turing or newer).

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.logitech.wireless.enable = true; # Enable logitech k400 support
  hardware.logitech.wireless.enableGraphical = true;

  hardware.new-lg4ff.enable = true; # Enable LogiTech G29 support
}
