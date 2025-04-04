{ config, pkgs, ... }:
{
  imports = [
    ../../home/gc.nix
    ../../home/fish.nix
    ../../home/network.nix
    ../../home/internet.nix
    ../../home/utils.nix
    ../../home/media.nix
    ../../home/gaming.nix
    ../../home/music.nix
    ../../home/dev.nix
  ];

  home.username = "mk";
  home.homeDirectory = "/home/mk";
  home.stateVersion = "23.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    loopbackwebcam
    nvtopPackages.amd
    blender-hip
    calibre
    thunderbird
  ];
}
