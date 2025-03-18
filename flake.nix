{
  description = "NixOS configurations";
  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-yuzu-unstable.url = "nixpkgs/f20a0c955555fb68cfc72886d7476de2aacd1b4e";
    nixpkgs-yabridge-unstable.url = "nixpkgs/03ddbd42cbdfbca5ce5583a8c1b526f36c0d46f3"; # wineWow64Packages.unstable: 9.19 -> 9.20
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
      self,
      nixpkgs-unstable,
      nixpkgs-yuzu-unstable,
      nixpkgs-yabridge-unstable,
      home-manager,
      flake-programs-sqlite,
      fjordlauncher,
      ...
    }:
    let
      system = "x86_64-linux";
      nixpkgs = nixpkgs-unstable;
      specialArgs = {
        inherit nixpkgs; # get nixpkgs for setting nix.registry.nixpkgs in system/configuration.nix file
      };
      mkMachine =
        machineModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          inherit specialArgs;
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
              nixpkgs = (import ./overlays.nix) { inherit inputs; };
            }
            flake-programs-sqlite.nixosModules.programs-sqlite
          ] ++ machineModules;
        };
    in
    {
      nixosConfigurations = {
        t1000 = mkMachine [
          system/t1000/configuration.nix
          { home-manager.users.mk = import home/mk.nix; }
        ];
        t800 = mkMachine [
          system/t800/configuration.nix
          { home-manager.users.home = import home/home.nix; }
        ];
        t70 = mkMachine [
          system/t70/configuration.nix
          { home-manager.users.s = import home/s.nix; }
        ];
      };

      devShells.default =
        with import nixpkgs { inherit system; };
        mkShell {
          buildInputs = [
            nixd
            nixfmt-rfc-style
            nix-index
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
