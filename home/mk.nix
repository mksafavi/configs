{ config, pkgs, ... }: {
  imports = [
    ./base/fish.nix
    ./base/network.nix
    ./base/utils.nix
    ./base/media.nix
    ./base/gaming.nix
    ./base/music.nix
    ./base/virtualization.nix
    ./base/dev.nix
  ];

  home.username = "mk";
  home.homeDirectory = "/home/mk";
  home.stateVersion = "23.11";
  home.sessionVariables.NIX_PATH =
    "nixpkgs=flake:nixpkgs\${NIX_PATH:+:$NIX_PATH}";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    loopbackwebcam
    nvtopPackages.amd
    obsidian
    blender-hip
    zerotierone
    syncthing
    calibre
  ];
}
