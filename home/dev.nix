{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    homeModules.dev = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether to enable development tools
        '';
      };
    };
  };
  config = lib.mkIf config.homeModules.dev.enable {
    home.packages = with pkgs; [
      ripgrep
      semgrep
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
  };
}
