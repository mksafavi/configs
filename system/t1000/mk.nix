{ config, pkgs, ... }:
{
  homeModules.internet.enable = true;
  homeModules.media.enable = true;
  homeModules.gaming.enable = true;
  homeModules.music.enable = true;
  homeModules.dev.enable = true;

  home.username = "mk";
  home.homeDirectory = "/home/mk";
  home.stateVersion = "23.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    loopbackwebcam
    nvtopPackages.amd
    blender
    calibre
    thunderbird
  ];
}
