{ config, pkgs, ... }:
{
  imports = [
    ./base/gc.nix
    ./base/fish.nix
    ./base/network.nix
    ./base/internet.nix
    ./base/utils.nix
    ./base/media.nix
    ./base/gaming.nix
    ./base/music.nix
    ./base/dev.nix
  ];

  home.username = "mk";
  home.homeDirectory = "/home/mk";
  home.stateVersion = "23.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    loopbackwebcam
    nvtopPackages.amd
    calibre
    thunderbird
  ];
}
