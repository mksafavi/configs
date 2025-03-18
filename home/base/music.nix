{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    yabridge
    yabridgectl
    reaper
    helvum
    noise-repellent
  ];

  home.file.".config/REAPER/UserPlugins/reaper_reapack-x86_64.so".source = pkgs.fetchurl {
    url = "https://github.com/cfillion/reapack/releases/download/v1.2.4.5/reaper_reapack-x86_64.so"; # TODO: this binary might stop working at some point.
    hash = "sha256-h3r3tF3XRjqY3Xy57Uaypg3pdJbyZ/zTyzF2DFmEJEA=";
  };
}
