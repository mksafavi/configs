{ pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs;[ 
    vscode
    nixfmt-rfc-style
   ];
}

