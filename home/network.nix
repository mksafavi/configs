{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wget
    nload
    aria2
    dprox
    nmap
    yt-dlp
    tun2proxy
    dig
  ];
  home.file.".config/aria2/aria2.conf".text = ''
    continue
    max-connection-per-server=5
    async-dns=false
  '';
}
