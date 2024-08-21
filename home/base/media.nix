{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ vlc ];
  programs.mpv = {
    enable = true;
    scripts = with pkgs; [
      mpvScripts.uosc
      mpvScripts.mpris
    ];
  };
}
