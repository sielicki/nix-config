{ config, home-manager, suites, ... }:
{
  imports = [ ../sielicki-base.nix ];
  home-manager.users.sielicki = { suites, ... }: {
    imports = suites.base;
  };
}
