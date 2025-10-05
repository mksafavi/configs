{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    homeModules.media = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether to enable media and video tools
        '';
      };
    };
  };
  config = lib.mkIf config.homeModules.media.enable {

    home.packages = with pkgs; [
      vlc
      termsonic
      ffmpeg
    ];
    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        uosc
        mpris
        mpv-cheatsheet
        webtorrent-mpv-hook
        thumbfast
        skipsilence
      ];
    };
  };
}
