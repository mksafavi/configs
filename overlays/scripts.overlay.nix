final: prev:
{
    dprox = (prev.callPackage ../scripts/dprox.nix { });
    loopbackwebcam = (prev.callPackage ../scripts/loopbackwebcam.nix { });
}

