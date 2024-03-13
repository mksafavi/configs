{ inputs, system, ... }:

with inputs;

let
  nixosSystem = nixpkgs.lib.nixosSystem;
  mkMachine = extraModules:
    nixosSystem {
      inherit system;
      specialArgs = { inherit nixpkgs; };
      modules = [
        ../system/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs =
            true; # home-manager uses the global pkgs that is configured via the system level nixpkgs options. this is necessary for allowing unfree apps on home-manager
          home-manager.useUserPackages =
            true; # packages will be installed to /etc/profiles instead of $HOME/.nix-profile
        }
      ] ++ extraModules;
    };
in {
  t800 = mkMachine [ ../system/t800/configuration.nix ];
  t1000 = mkMachine [ ../system/t1000/configuration.nix ];
}
