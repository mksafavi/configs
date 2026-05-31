{ inputs, ... }:
{
  overlays = [
    (final: prev: {
      dprox = (prev.callPackage ./scripts/dprox.nix { });
      loopbackwebcam = (prev.callPackage ./scripts/loopbackwebcam.nix { });
      nix-profile-diff = (prev.callPackage ./scripts/nix-profile-diff.nix { });
    })
    inputs.fjordlauncher.overlays.default
    (final: prev: { # Revert when https://github.com/NixOS/nixpkgs/pull/525133 is merged
      openldap = prev.openldap.overrideAttrs (old: {
        preCheck =
          old.preCheck
          + prev.lib.optionalString prev.stdenv.hostPlatform.isi686 ''
            rm -f tests/scripts/test*-sync*
          '';
      });
    })
  ];
}
