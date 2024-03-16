{ config, pkgs, ... }: {
  programs.home-manager.enable = true;
  imports = [
    ./network.nix
    ./utils.nix
    ./media.nix
    ./gaming.nix
    ];
  home.packages = with pkgs; [ ];
}
