{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = inputs:
    let system = "x86_64-linux";
    in {
      nixosConfigurations =
        (import ./outputs/nixos-conf.nix { inherit inputs system; });
    };
}
