{ config, pkgs, ... }:
{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;
  services.speechd.enable = false;
  services.orca.enable = false;
}
