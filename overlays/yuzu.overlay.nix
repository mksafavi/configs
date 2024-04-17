final: prev:
let
  nixpkgs-yuzu =
    import
      (prev.fetchFromGitHub {
        # https://github.com/NixOS/nixpkgs/pull/295587
        owner = "NixOS";
        repo = "nixpkgs";
        rev = "f20a0c955555fb68cfc72886d7476de2aacd1b4e";
        sha256 = "irN9RgAuoouk7PhQapw6/p2hhwUNHwIPHE6b6ZaE5nE=";
      })
      {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
in
{
  inherit (nixpkgs-yuzu) yuzu;
}
