{ config, pkgs, ... }:
{
  imports = [
    ./base/network.nix
    ./base/utils.nix
    ./base/media.nix
    ./base/gaming.nix
    ./base/music.nix
    ./base/virtualization.nix
  ];
  home.username = "mk";
  home.homeDirectory = "/home/mk";
  home.stateVersion = "23.11";
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    loopbackwebcam
    nvtopPackages.amd
    obsidian
    blender-hip
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
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
    set -gx EDITOR vim
  '';
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
