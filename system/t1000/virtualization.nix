{ config, pkgs, ... }:
{
  virtualisation = {
    docker.enable = true;
    podman.enable = true;
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [
        virtiofsd
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    virt-manager
    gnome-boxes
  ];
}
