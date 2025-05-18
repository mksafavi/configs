{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    vlc
    kooha
    termsonic
    ffmpeg
  ];
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      mpris
      mpv-cheatsheet
      webtorrent-mpv-hook
      thumbfast
      skipsilence
    ];
  };
}
