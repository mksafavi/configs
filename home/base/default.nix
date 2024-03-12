{ config, pkgs, ... }: {
  programs.home-manager.enable = true;
  imports = [
    ./network.nix
    ./utils.nix
    ];
  home.packages = with pkgs; [ ];
}
