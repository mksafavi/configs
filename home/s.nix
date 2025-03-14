{ config, pkgs, ... }:
{
  imports = [
    ./base/gc.nix
    ./base/fish.nix
    ./base/network.nix
    ./base/utils.nix
  ];

  home.username = "s";
  home.homeDirectory = "/home/s";
  home.stateVersion = "24.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
  ];
}
