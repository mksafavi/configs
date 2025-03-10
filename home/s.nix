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
  home.sessionVariables.NIX_PATH = "nixpkgs=flake:nixpkgs\${NIX_PATH:+:$NIX_PATH}";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
  ];
}
