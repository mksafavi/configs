{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    vim
    wget
    lf
  ];
  home.stateVersion = "23.05";
}
