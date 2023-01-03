{ config, lib, profiles, pkgs, ... }:
{
  imports = [
    profiles.core.secrets
  ];
  users.users.sielicki = {
    description = "Nicholas Sielicki";
  } // lib.mkIf (!pkgs.stdenv.isDarwin) {
    createHome = true;
    extraGroups = [ "networkmanager" "wheel" ];
    passwordFile = config.age.secrets.sielicki-personal-password.path;
    isNormalUser = true;
  };
}
