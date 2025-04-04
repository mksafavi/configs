{ config, pkgs, ... }:
{
  nix = {
    gc = {
      # Garbage Collection home-manager
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
