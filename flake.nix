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

  outputs = inputs:
    let system = "x86_64-linux";
    in {
      nixosConfigurations =
        (import ./outputs/nixos-conf.nix { inherit inputs system; });
    };
}
