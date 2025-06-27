{ inputs, ... }:
{
  overlays = [
    (final: prev: { yuzu = inputs.nixpkgs-yuzu-unstable.legacyPackages.${prev.system}.yuzu; })
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
    (final: prev: {
      linuxPackages_latest = prev.linuxPackages_latest.extend (
        lpself: lpsuper: {
          new-lg4ff = prev.linuxPackages_latest.new-lg4ff.overrideAttrs (old: {
            patches = [
              (prev.fetchpatch {
                url = "https://github.com/NixOS/nixpkgs/pull/411809.patch";
                hash = "sha256-0z2eCquKKRp2zFUBelFzQOQtQP+JwTk7sn856jADpL8=";
              })
            ];
          });
        }
      );
    })
  ];
}
