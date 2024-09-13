{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    ripgrep
    fd
    shellcheck
    nixfmt-rfc-style
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  programs.emacs = {
    enable = true;
    #install = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

}
