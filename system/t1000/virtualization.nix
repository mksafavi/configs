{ config, pkgs, ... }:
{
  virtualisation = {

    docker.enable = true;
    podman.enable = true;
  };

  users.users.mk = {
    packages = with pkgs; [
      podman-compose
    ];
  };
}
