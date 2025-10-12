{ inputs, ... }:
{
  overlays = [
    (final: prev: {
      yabridge = inputs.nixpkgs-yabridge-unstable.legacyPackages.${prev.system}.yabridge;
      yabridgectl = inputs.nixpkgs-yabridge-unstable.legacyPackages.${prev.system}.yabridgectl;
    })
    (final: prev: {
      dprox = (prev.callPackage ./scripts/dprox.nix { });
      loopbackwebcam = (prev.callPackage ./scripts/loopbackwebcam.nix { });
      nix-profile-diff = (prev.callPackage ./scripts/nix-profile-diff.nix { });
    })
    inputs.fjordlauncher.overlays.default

    (final: prev: {
      nix-fast-build = prev.nix-fast-build.overrideAttrs (old: {
        propagatedBuildInputs = old.propagatedBuildInputs ++ [ prev.bashInteractive ];
      });
    })
  ];
}
