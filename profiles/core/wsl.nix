{ config, lib, pkgs, self, wsl, ... }:

{
  imports = [
    ./nixos.nix
    ${wsl}/modules/wsl-distro.nix
    ${wsl}/modules/wsl-conf.nix
    ${wsl}/modules/interop.nix
  ];
  config.wsl = {
    enable = true;
    nativeSystemd = true;
    defaultUser = "sielicki";
    startMenuLaunchers = true;
    interop.enabled = true;
  };

}
