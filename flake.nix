{
  description = "NixOS configurations";
  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-yabridge-unstable.url = "nixpkgs/03ddbd42cbdfbca5ce5583a8c1b526f36c0d46f3"; # wineWow64Packages.unstable: 9.19 -> 9.20
    nixpkgs-441565.url = "nixpkgs/af0d1d900bf25def45873cbee6c43d48f97a5e7f"; # nixos/autoUpgrade: add runGarbageCollection option
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
    { self, ... }@inputs:
    let
      system = "x86_64-linux";
      nixpkgs = inputs.nixpkgs-unstable;
      specialArgs = {
        inherit nixpkgs; # get nixpkgs for setting nix.registry.nixpkgs in system/configuration.nix file
      };
      mkMachine =
        machineModule:
        nixpkgs.lib.nixosSystem {
          inherit system;
          inherit specialArgs;
          modules = [
            ({
              disabledModules = [
                ("${nixpkgs}/nixos/modules/tasks/auto-upgrade.nix")
              ];
            })
            ("${inputs.nixpkgs-441565}/nixos/modules/tasks/auto-upgrade.nix")
            inputs.home-manager.nixosModules.default
            {
              home-manager = {
                extraSpecialArgs = specialArgs;
                useGlobalPkgs = true; # home-manager uses the global pkgs that is configured via the system level nixpkgs options. this is necessary for allowing unfree apps on home-manager
                useUserPackages = true; # packages will be installed to /etc/profiles instead of $HOME/.nix-profile
                sharedModules = [
                  home/dev.nix
                  home/fish.nix
                  home/gaming.nix
                  home/gc.nix
                  home/internet.nix
                  home/media.nix
                  home/music.nix
                  home/network.nix
                  home/utils.nix
                ];
              };
              nix.registry.nixpkgs.flake = nixpkgs;
            }
            {
              nixpkgs = (import ./overlays.nix) { inherit inputs; };
            }
            inputs.flake-programs-sqlite.nixosModules.programs-sqlite # programs database used for commandnotfound hints
            modules/networking.nix
            modules/desktop.nix
            modules/nix-configuration.nix
            services/attic-watch-store.nix
            services/timetagger.nix
            services/openrgb.nix
            services/flake-build.nix
            machineModule
          ];
        };
    in
    {
      nixosConfigurations = {
        t1000 = mkMachine system/t1000/configuration.nix;
        t800 = mkMachine system/t800/configuration.nix;
        t70 = mkMachine system/t70/configuration.nix;
      };

      devShells.default =
        with import nixpkgs { inherit system; };
        mkShell {
          buildInputs = [
            nixd
            nixfmt-rfc-style
            nix-index
            nix-tree
            wl-clipboard # needed by nix-tree
            nix-fast-build
          ];
        };

      checks =
        let
          systemsAttrs = nixpkgs.lib.mapAttrs' (
            n: c: nixpkgs.lib.nameValuePair "nixos-${n}" c.config.system.build.toplevel
          ) self.nixosConfigurations;
          devShellsAttrs = nixpkgs.lib.mapAttrs' (
            n: nixpkgs.lib.nameValuePair "devShell-${n}"
          ) self.devShells;

        in
        (systemsAttrs // devShellsAttrs);
    };
}
