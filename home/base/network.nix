{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wget
    firefox
    chromium
    telegram-desktop
    bandwhich
    nload
    qv2ray
    aria
    dprox
    nmap
    yt-dlp
  ];
  home.file.".config/aria2/aria2.conf".text = ''
    continue
    max-connection-per-server=5
    async-dns=false
  '';
}
