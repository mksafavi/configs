{
  description = "NixOS configurations";
  nixConfig = {
substituters = [
      "http://192.168.1.100:5000"
      "https://cache.nixos.org"
    ];
  trusted-public-keys = [
"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
"cache.example.org-1:VrVDVUwlg6FmNGX1UAIb8DCs6p3gFtoTQCCpfsym5Mc="
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
