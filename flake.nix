{
  description = "NixOS configurations";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, musnix, ... }:
    let
      system = "x86_64-linux";
      mkMachine = machineModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit nixpkgs;
          };
          modules = [ system/configuration.nix ] ++ machineModules;
        };
    in {
      nixosConfigurations = {
        t1000 = mkMachine [
          system/t1000/configuration.nix
          musnix.nixosModules.musnix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.mk = import home/mk.nix;
              # home-manager uses the global pkgs that is configured via the system level nixpkgs options. this is necessary for allowing unfree apps on home-manager
              useGlobalPkgs = true;
              # packages will be installed to /etc/profiles instead of $HOME/.nix-profile
              useUserPackages = true;
            };
          }
        ];
        t800 = mkMachine [
          system/t800/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.home = import home/home.nix;
              # home-manager uses the global pkgs that is configured via the system level nixpkgs options. this is necessary for allowing unfree apps on home-manager
              useGlobalPkgs = true;
              # packages will be installed to /etc/profiles instead of $HOME/.nix-profile
              useUserPackages = true;
            };
          }
        ];

      };
    };
}
