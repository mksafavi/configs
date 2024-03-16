{ config, pkgs, ... }: {
  imports = [
    ./base
    ./base/music.nix
    ];
  home.username = "mk";
  home.homeDirectory = "/home/mk";
  home.stateVersion = "23.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    nvtop-amd
  ];
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };
  programs.bash.enable = true;
}
