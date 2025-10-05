{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    homeModules.fish = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = lib.mdDoc ''
          Whether to enable fish shell
        '';
      };
    };
  };
  config = lib.mkIf config.homeModules.fish.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -gx EDITOR vim
        set fish_greeting # Disable greeting
      '';
    };

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
  };
}
