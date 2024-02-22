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
  vm = mkMachine ../system/machine/vm;
  t800 = mkMachine ../system/machine/t800;
}
