{
  description = "NixOS configurations";
  nixConfig = {
substituters = [
      http://192.168.1.100:8080/
      https://cache.nixos.org/
    ];
  trusted-public-keys = [cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=];
  trusted-substituters = [
      http://192.168.1.100:8080/
    ];
};

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let system = "x86_64-linux";
    in
    {
      homeConfigurations =
        (import ./outputs/home-conf.nix { inherit inputs system; });

      nixosConfigurations =
        (import ./outputs/nixos-conf.nix { inherit inputs system; });
    };
}
