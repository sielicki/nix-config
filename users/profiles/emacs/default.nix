{ pkgs, config, system, inputs, ... }:
let
  emacsPackage = pkgs.emacsGit;
  emacsInitFile = ./config/init.el;
  emacs = pkgs.emacsWithPackagesFromUsePackage {
    package = emacsPackage;
    config = emacsInitFile;
    defaultInitFile = true;
    alwaysEnsure = true;
    extraEmacsPackages = epkgs: [
      epkgs.bind-key
      epkgs.use-package
      epkgs.org-contrib
    ];
  };
in
{
  services.emacs = {
    enable = !pkgs.stdenv.isDarwin;
    package = emacs;
    socketActivation.enable = true;
    defaultEditor = true;
    client = {
      enable = true;
      arguments = [
        "--no-wait"
        "--create-frame"
      ];
    };
  };

  home.file.".emacs.d/early-init.el".source = ./config/early-init.el;
  home.file.".emacs.d/imagine_happy.svg".source = ./config/imagine_happy.svg;

  home.packages = [
    emacs
  ];

  home.sessionVariables = {
    ALTERNATIVE_EDITOR = "";
  };

  home.shellAliases = {
    edit = "emacsclient -n";
    nedit = "emacsclient -n -c";
    tedit = "emacsclient -n -c -t";
  };
}






