{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    modules.gc = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = lib.mdDoc ''
          Whether to enable Nix garbage collection
        '';
      };
    };
  };
  config = lib.mkIf config.modules.gc.enable {
    nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d"; # revert when this is merged: https://github.com/NixOS/nix/pull/10426
      };
    };
  };
}
