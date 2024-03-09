{
  description = "NixOS configurations";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{nixpkgs, home-manager, ...}:
    let system = "x86_64-linux";
    in
    {
      homeConfigurations =
        (import ./outputs/home-conf.nix { inherit nixpkgs home-manager system; });

      nixosConfigurations =
        (import ./outputs/nixos-conf.nix { inherit nixpkgs system; });
    };
}
