{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    vlc
    kooha
    termsonic
  ];
  programs.mpv = {
    enable = true;
    scripts = with pkgs; [
      mpvScripts.uosc
      mpvScripts.mpris
    ];
  };
}
