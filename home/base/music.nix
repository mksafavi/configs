{ config, pkgs, ... }: {
  home.packages = with pkgs; [ 
    yabridge
    yabridgectl
    reaper
  ];
}