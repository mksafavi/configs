# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:

{
  imports = [
    ./warp.nix
    ./xray.nix
  ];
  nix = {
    # Garbage Collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d"; # reverd when this is merged: https://github.com/NixOS/nix/pull/10426
    };

    # Flakes settings
    package = pkgs.nixUnstable;
    registry.nixpkgs.flake = nixpkgs; # use nixpkgs for flake commands instead of downloading flake-registry
    nixPath = [ "nixpkgs=${nixpkgs}" ]; # use nixpkgs for legacy commands instead of downloading flake-registry
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = true;
    };
  };

  services = {
    xray-proxy = {
      enable = true;
      configFile = "~/xray_config/direct.json";
    };
  };
}
