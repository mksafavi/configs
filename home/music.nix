{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    yabridge
    yabridgectl
    reaper
    helvum
    noise-repellent
  ];

  xdg.configFile."REAPER" = {
    source = pkgs.symlinkJoin {
      name = "reaper-userplugins";
      paths = with pkgs; [
        reaper-sws-extension
        reaper-reapack-extension
      ];
    };
    recursive = true;
  };
}
