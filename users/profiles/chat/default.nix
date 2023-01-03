{ pkgs, ... }:

let
  inherit (builtins) readFile;
in
{
  home.packages = [
    pkgs.discord
    pkgs.element-desktop
  ];
  programs.discocss = {
    enable = true;
    discordAlias = false;
    discordPackage = pkgs.discord;
    css = (readFile ./customcss.css);
  };
}
