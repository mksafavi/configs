{ config, pkgs, ... }:
{
  home.username = "mk";
  home.homeDirectory = "/home/mk";
  home.stateVersion = "23.11";
services.kdeconnect.enable = true;
  home.packages = with pkgs; [
    vim
    wget
    lf
firefox
lutris
wine
telegram-desktop
qv2ray
nvtop-amd
usbutils
htop
iotop
btop
ncdu
nethogs
chromium
mangohud
  ];

programs.direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
programs.bash.enable = true;
}
