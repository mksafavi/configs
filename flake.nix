{
  description = "NixOS configurations";
  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    fjordlauncher = {
      url = "github:hero-persson/FjordLauncherUnlocked";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs-unstable,
      home-manager,
      flake-programs-sqlite,
      fjordlauncher,
      deploy-rs,
      ...
    }:
    let
      system = "x86_64-linux";
      nixpkgs = nixpkgs-unstable;
      mkMachine =
        machineModules:
        nixpkgs.lib.nixosSystem rec {
          inherit system;
          specialArgs = {
            inherit nixpkgs; # get nixpkgs for setting nix.registry.nixpkgs in system/configuration.nix file
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
              nix.registry.nixpkgs.flake = nixpkgs;
            }
            {
              nixpkgs.overlays = [
                (import overlays/yuzu.overlay.nix)
                (import overlays/yabridge.overlay.nix)
                (import overlays/scripts.overlay.nix)
                fjordlauncher.overlays.default
              ];
            }
            flake-programs-sqlite.nixosModules.programs-sqlite
          ] ++ machineModules;
        };
    in
    {
      nixosConfigurations = {
        t1000 = mkMachine [
          system/t1000/configuration.nix
          home-manager.nixosModules.home-manager
          { home-manager.users.mk = import home/mk.nix; }
        ];
        t800 = mkMachine [
          system/t800/configuration.nix
          home-manager.nixosModules.home-manager
          { home-manager.users.home = import home/home.nix; }
        ];
        t70 = mkMachine [
          system/t70/configuration.nix
          home-manager.nixosModules.home-manager
          { home-manager.users.s = import home/s.nix; }
        ];
      };
      deploy.nodes = {
        t1000 = {
          interactiveSudo = true;
          sshUser = "mk";
          hostname = "t1000.lan";
          fastConnection = true;
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.t1000;
          };
        };
        t800 = {
          interactiveSudo = true;
          sshUser = "home";
          hostname = "t800.lan";
          fastConnection = true;
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.t800;
          };
        };
        t70 = {
          interactiveSudo = true;
          sshUser = "s";
          hostname = "t70.lan";
          fastConnection = true;
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.t70;
          };
        };
      };
      devShells.default =
        with import nixpkgs { inherit system; };
        mkShell {
          buildInputs = [
            nixd
            nixfmt-rfc-style
            nix-index
            pkgs.deploy-rs
          ];
        };
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
