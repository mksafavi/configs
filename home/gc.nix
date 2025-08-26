{ config, pkgs, ... }:
{
  nix = {
    gc = {
      # Garbage Collection home-manager
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
