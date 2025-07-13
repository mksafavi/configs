{ config, pkgs, ... }:
{
  imports = [
    ../../home/gc.nix
    ../../home/fish.nix
    ../../home/network.nix
    ../../home/internet.nix
    ../../home/utils.nix
    ../../home/media.nix
    ../../home/dev.nix
  ];

  home.username = "anna";
  home.homeDirectory = "/home/anna";
  home.stateVersion = "24.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
  ];
}
