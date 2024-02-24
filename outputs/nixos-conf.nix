{ inputs, system, ... }:

let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
  mkMachine = confPath:
    nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [ confPath ../system/configuration.nix ];
    };
in
{
  vm = mkMachine ../system/vm;
  t800 = mkMachine ../system/t800;
  t1000 = mkMachine ../system/t1000;
}
