{ config, pkgs, ... }: {
  #home tv pc configurations
  imports = [./base];
  home.username = "home";
  home.homeDirectory = "/home/home";
  home.stateVersion = "23.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [  ];
}
