{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    vlc
    kooha
  ];
  programs.mpv = {
    enable = true;
    scripts = with pkgs; [
      mpvScripts.uosc
      mpvScripts.mpris
    ];
  };
}
