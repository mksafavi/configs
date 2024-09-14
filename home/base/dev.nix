{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    ripgrep
    fd
    shellcheck
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

}
