{ config, pkgs, ... }:
{
  imports = [
    ../../home/gc.nix
    ../../home/fish.nix
    ../../home/network.nix
    ../../home/utils.nix
  ];

  home.username = "s";
  home.homeDirectory = "/home/s";
  home.stateVersion = "24.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
  ];
}
