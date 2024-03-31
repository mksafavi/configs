{ config, pkgs, ... }: {
  home.packages = with pkgs; [ 
    (lutris.override { extraPkgs = pkgs: [ wineWowPackages.stable ]; })
    mangohud
    #yuzu # TODO: install this from the old nixpkgs rev
    ryujinx
  ];
}
