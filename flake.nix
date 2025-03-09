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
  };

  outputs =
    inputs@{
      nixpkgs-unstable,
      home-manager,
      flake-programs-sqlite,
      fjordlauncher,
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
      };
      devShells.default =
        with import nixpkgs { inherit system; };
        mkShell {
          buildInputs = [
            nixd
            nixfmt-rfc-style
            nix-index
          ];
        };
    };
}
