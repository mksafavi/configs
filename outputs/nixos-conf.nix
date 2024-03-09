{ nixpkgs, system, ... }:

let
  nixosSystem = nixpkgs.lib.nixosSystem;
  mkMachine = confPath:
    nixosSystem {
      inherit system;
      specialArgs = { inherit nixpkgs; };
      modules = [
      confPath
      ../system/configuration.nix
      ];
    };
in
{
  t800 = mkMachine ../system/t800;
  t1000 = mkMachine ../system/t1000;
}
