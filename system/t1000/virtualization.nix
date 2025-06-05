{ config, pkgs, ... }:
{
  virtualisation = {

    docker.enable = true;
    podman.enable = true;
    libvirtd.enable = true;
  };

  users.users.mk = {
    packages = with pkgs; [
      podman-compose
      virt-manager
      gnome-boxes
    ];
  };
}
