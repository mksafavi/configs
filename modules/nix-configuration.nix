{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:

{
  nix = {
    # Garbage Collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d"; # reverd when this is merged: https://github.com/NixOS/nix/pull/10426
    };

    # Flakes settings
    package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = nixpkgs; # use nixpkgs for flake commands instead of downloading flake-registry
    nixPath = [
      "nixpkgs=flake:${nixpkgs}" # use nixpkgs for legacy commands instead of downloading flake-registry
    ];
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

  nixpkgs.config.allowUnfree = true;

  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;
  };
}
