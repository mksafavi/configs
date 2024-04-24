{ config, pkgs, ... }:
{
  imports = [
    ../scripts/dprox.nix
    ../scripts/loopbackwebcam.nix
  ];
}
