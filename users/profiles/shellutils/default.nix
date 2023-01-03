{ pkgs, ... }:
{
  imports = [ ./bat ];

  programs.exa = {
    enable = true;
    enableAliases = false;
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
    settings = {
      ignore-globs = [ ".git" ".hg" ];
    };
  };

  programs.bat = {
    enable = true;
    config = {
      map-syntax = [ "*.jenkinsfile:Groovy" "*.props:Java Properties" ];
    };
    # extraPackages = with pkgs.bat-extras; [
    #   batman
    #   batgrep
    #   batpipe
    #   batwatch
    #   batdiff
    #   prettybat
    # ];
  };


  home.packages = [
    pkgs.bashInteractive
    pkgs.fd
    pkgs.openssh
    pkgs.mosh
    pkgs.ripgrep
    pkgs.rsync
    pkgs.tree
    pkgs.helix
    pkgs.ripgrep
    pkgs.watch
    pkgs.wget
    pkgs.curl
    pkgs.nixos-generators
    pkgs.htop
    pkgs.bat-extras.batdiff
    pkgs.bat-extras.batman
    pkgs.bat-extras.batgrep
    pkgs.bat-extras.batwatch
    pkgs.bat-extras.prettybat
    #pkgs.bat-extras.batpipe
  ];
}
