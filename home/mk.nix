{config, pkgs, ...}:
{
home.packages = with pkgs; [ 
vim
wget
git
lf
 ];
home.stateVersion = "23.05";
}
