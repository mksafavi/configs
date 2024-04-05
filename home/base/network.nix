{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    wget
    firefox
    chromium
    telegram-desktop
    nethogs
    nload
    qv2ray
    aria
  ];
  home.file.".config/aria2/aria2.conf".text = ''
    continue
    max-connection-per-server=5
    async-dns=false
  '';
}
