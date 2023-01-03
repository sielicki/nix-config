{ pkgs, extraModulesPath, inputs, lib, ... }:
let

  inherit (pkgs)
    agenix
    cachix
    editorconfig-checker
    mdbook
    nixUnstable
    nixpkgs-fmt
    ;

  hooks = import ./hooks;

  pkgWithCategory = category: package: { inherit package category; };
  general = pkgWithCategory "general";
  maint = pkgWithCategory "maint";
  docs = pkgWithCategory "docs";

in
{
  _file = toString ./.;

  imports = [ "${extraModulesPath}/git/hooks.nix" ];
  git = { inherit hooks; };

  commands = [
    (general nixUnstable)
    (general agenix)
    (general inputs.deploy.packages.${pkgs.system}.deploy-rs)

    (maint nixpkgs-fmt)
    (maint editorconfig-checker)

    (docs mdbook)
  ]
  ++ lib.optionals (!pkgs.stdenv.buildPlatform.isi686) [
    (general cachix)
  ]
  ++ lib.optionals (pkgs.stdenv.hostPlatform.isLinux) [
    (general inputs.nixos-generators.defaultPackage.${pkgs.system})
  ]
  ;
}
