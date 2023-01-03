{ config, pkgs, suites, ... }:

{
  imports = with suites; base ++ personal ++ hm-heavy;


  nix.extraOptions = ''
    builders-use-substitutes = true
    system-features = recursive-nix
    extra-experimental-features = nix-command flakes recursive-nix
    flake-registry = /etc/nix/registry.json
    extra-platforms = x86_64-darwin
  '';
  # extra-substituters = https://nix-config.cachix.org https://nrdxp.cachix.org https://nix-community.cachix.org
  # extra-trusted-public-keys = nix-config.cachix.org-1:Vd6raEuldeIZpttVQfrUbLvXJHzzzkS0pezXCVVjDG4= nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=


  system.stateVersion = 4;
  programs.zsh.enable = true;
  environment.systemPackages = [
    pkgs.vim
    pkgs.iterm2
    pkgs.kitty
    #pkgs.firefox
  ];

  nix.package = pkgs.nix;
}
