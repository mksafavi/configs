{ config, pkgs, ... }:
{
  nix = {
    # Garbage Collection
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
