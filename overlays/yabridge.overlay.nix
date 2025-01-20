final: prev:
let
  nixpkgs-wine = import (prev.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "03ddbd42cbdfbca5ce5583a8c1b526f36c0d46f3"; # wineWow64Packages.unstable: 9.19 -> 9.20
    sha256 = "sha256-/T/nMj4oOfiyhiBol4Bzh2EYdJunNo8zXzBoR8vVChY=";
  }) { system = "x86_64-linux"; };
in
{
  inherit (nixpkgs-wine) yabridge yabridgectl;
}
