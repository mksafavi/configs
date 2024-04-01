{ config, pkgs, ... }: {
  imports = [
    ./network.nix
    ./utils.nix
    ./media.nix
    ./gaming.nix
    ];
  home.packages = with pkgs; [ ];
}
