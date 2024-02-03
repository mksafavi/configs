{config, pkgs, ...}:
{
home.packages = with pkgs; [ jq ];
home.stateVersion = "23.05";
}
