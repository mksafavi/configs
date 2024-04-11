{
  description = "NixOS configurations";
  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs@{ nixpkgs-unstable, home-manager, musnix, ... }:
    let
      system = "x86_64-linux";
      nixpkgs = nixpkgs-unstable;
      mkMachine = machineModules:
        nixpkgs.lib.nixosSystem rec {
          inherit system;
          specialArgs = {
            inherit nixpkgs; # get nixpkgs for setting nix.registry.nixpkgs in system/configuration.nix file
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
              overlays = [ 
                (import overlays/yuzu.overlay.nix) 
                (import overlays/yabridge.overlay.nix) 
                (import overlays/rpcs3.overlay.nix) 
                ];
            };
          };
          modules = [
            system/configuration.nix
            home-manager.nixosModules.default
            {
              home-manager = {
                extraSpecialArgs = specialArgs;
                useGlobalPkgs = true; # home-manager uses the global pkgs that is configured via the system level nixpkgs options. this is necessary for allowing unfree apps on home-manager
                useUserPackages = true; # packages will be installed to /etc/profiles instead of $HOME/.nix-profile
              };
            }

          ] ++ machineModules;
        };
    in {
      nixosConfigurations = {
        t1000 = mkMachine [
          system/t1000/configuration.nix
          musnix.nixosModules.musnix
          home-manager.nixosModules.home-manager
          { home-manager.users.mk = import home/mk.nix; }
        ];
        t800 = mkMachine [
          system/t800/configuration.nix
          home-manager.nixosModules.home-manager
          { home-manager.users.home = import home/home.nix; }
        ];

      };
    };
}
