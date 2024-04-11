
final: prev:
let
  nixpkgs = import (prev.fetchFromGitHub {
    # https://github.com/NixOS/nixpkgs/issues/299439
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "9e7f26f82acb057498335362905fde6fea4ca50a"; # rpcs3: 0.0.29-15726-ebf48800e -> 0.0.31-16271-4ecf8ecd0
    sha256 = "VnG0Eu394Ga2FCe8Q66m6OEQF8iAqjDYsjmtl+N2omk=";
  }) { system = "x86_64-linux"; };
in {
  inherit (nixpkgs) rpcs3;
}