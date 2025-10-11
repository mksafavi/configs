{ config, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.display.outputs."HDMI-A-1".mode = "e";
  hardware.display.outputs."HDMI-A-1".edid = "tv.bin";
  hardware.display.edid.packages = [
    (pkgs.runCommand "tv-edid" { } ''
      mkdir -p "$out/lib/firmware/edid"
      base64 -d > "$out/lib/firmware/edid/tv.bin" <<'EOF'
      AP///////wBjGAAAAQAAAAEdAQOAc0F4Cs90o1dMsCMJSEwAAAABAQH/Af//AQEBAQEBAQEgCOgA
      MPJwWoCwWIoAuahCAAAeAjqAGHE4LUBYLEUAuahCAAAeAAAA/ABTTUFSVCBUVgogICAgAAAA/QA7
      Rh+MPAAKICAgICAgAWYCA03yWwWEAwESExQWB5AfICJdX2BhAGQAZl4AAgYRFSYJBwcRBwaDAQAA
      4wD//2cDDAAQAHhEZ9hdxAF4gAfjBf8B5Q8AgBkA4wYFAYwK0Iog4C0QED6WAMSOIQAAGIwKoBRR
      8BYAJnxDAMSOIQAAmAAAAAAAAAAAAAAAAAAAxw==
      EOF
    '')
  ];

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
