{ pkgs, config, ... }:
{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    emacsPackage = if pkgs.stdenv.isDarwin then pkgs.emacsMacport else pkgs.emacsUnstable;
  };
  services.emacs = {
    enable = !pkgs.stdenv.isDarwin;
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

  home.sessionVariables = {
    ALTERNATIVE_EDITOR = "";
  };

  home.shellAliases = {
    edit = "emacsclient -n";
    nedit = "emacsclient -n -c";
    tedit = "emacsclient -n -c -t";
  };
}






