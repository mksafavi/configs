{ config, pkgs, ... }:
{
  virtualisation = {

    docker.enable = true;
    podman.enable = true;
    libvirtd.enable = true;
  };

  virtualisation.oci-containers = {
    containers = {
      traggo = {
        image = "traggo/server:0.7.1";
        ports = [ "127.0.0.1:3030:3030" ];
        volumes = [ "${config.users.users.mk.home}/.local/share/traggo:/opt/traggo/data" ];
      };
    };
  };

  users.users.mk = {
    packages = with pkgs; [
      podman-compose
      virt-manager
      gnome-boxes
    ];
  };
}
