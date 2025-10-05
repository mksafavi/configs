{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    homeModules.internet = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether to enable internet tools
        '';
      };
    };
  };
  config = lib.mkIf config.homeModules.internet.enable {
    home.packages = with pkgs; [
      firefox
      chromium
      telegram-desktop
      localsend
      authenticator
      turnon
    ];
  };
}
