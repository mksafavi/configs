{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wget
    firefox
    chromium
    telegram-desktop
    bandwhich
    nload
    aria
    dprox
    nmap
    yt-dlp
    localsend
    tun2proxy
  ];
  home.file.".config/aria2/aria2.conf".text = ''
    continue
    max-connection-per-server=5
    async-dns=false
  '';
}
