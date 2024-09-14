{ lib, writeShellApplication }:
writeShellApplication {
  name = "nix-profile-diff";

  text = ''
      nix profile diff-closures --profile /nix/var/nix/profiles/system
  '';
}
