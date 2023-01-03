{ pkgs, ... }:
{
  programs.man = {
    enable = true;
    generateCaches = true;
  };
  home.packages = with pkgs; [
    man
    man-pages
    man-pages-posix
  ];
}
