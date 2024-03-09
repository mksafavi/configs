{ nixpkgs, home-manager, system, ... }:

let
  nixosSystem = nixpkgs.lib.nixosSystem;
  mkMachine = confPath:
    nixosSystem {
      inherit system;
      specialArgs = { inherit nixpkgs; };
      modules = [
      confPath
      ../system/configuration.nix
      home-manager.nixosModules.home-manager
      {
          home-manager.useGlobalPkgs = true;  # home-manager uses the global pkgs that is configured via the system level nixpkgs options. this is necessary for allowing unfree apps on home-manager
          home-manager.useUserPackages = true; # packages will be installed to /etc/profiles instead of $HOME/.nix-profile
          }
      ];
    };
in
{
  t800 = mkMachine ../system/t800;
  t1000 = mkMachine ../system/t1000;
}
