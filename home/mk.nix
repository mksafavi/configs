{ config, pkgs, ... }: {
  imports = [./base];
  home.username = "mk";
  home.homeDirectory = "/home/mk";
  home.stateVersion = "23.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    neovim
    (lutris.override { extraPkgs = pkgs: [ wineWowPackages.stable ]; })
    wineWowPackages.stable
    nvtop-amd
    mangohud
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };
  programs.bash.enable = true;
}
