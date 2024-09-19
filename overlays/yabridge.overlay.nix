final: prev:
let
  nixpkgs-wine98 = import (prev.fetchFromGitHub {
    # https://github.com/NixOS/nixpkgs/issues/300755
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "c8819597e3a2821d3b3c46b750723c25f95104c2"; # wineWow64Packages.unstable: 9.7 -> 9.8
    sha256 = "sha256-eu31wdy6wtBwCCnzpMSQHw0rsUo6tvj5En6WA8qv85Q=";
  }) { system = "x86_64-linux"; };
in
{
  inherit (nixpkgs-wine98) yabridge yabridgectl;
}
