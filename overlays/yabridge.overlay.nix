final: prev:
let
  nixpkgs-wine94 = import (prev.fetchFromGitHub {
    # https://github.com/NixOS/nixpkgs/issues/300755
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "59322d8a3603ef35a0b5564b00109f4a6436923e"; # wineWow64Packages.unstable: 9.3 -> 9.4
    sha256 = "Ln3mD5t96hz5MoDwa8NxHFq76B+V2BOppYf1tnwFBIc=";
  }) { system = "x86_64-linux"; };
in {
  inherit (nixpkgs-wine94) yabridge yabridgectl;
}
