{config, pkgs, ...}:
{
programs.home-manager.enable = true;
home.username = "mk";
home.homeDirectory = "/home/mk";
home.packages = with pkgs; [ ];
}
