final: prev:
{
    dprox = (prev.callPackage ../scripts/dprox.nix { });
    loopbackwebcam = (prev.callPackage ../scripts/loopbackwebcam.nix { });
    nix-profile-diff = (prev.callPackage ../scripts/nix-profile-diff.nix { });
}

