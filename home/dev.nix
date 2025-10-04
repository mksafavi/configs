{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    fd
    shellcheck
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.tree-sitter-langs
    ];
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    socketActivation.enable = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

}
