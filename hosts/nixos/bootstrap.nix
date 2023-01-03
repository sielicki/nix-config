{ profiles, ... }:
{
  imports = [
    # profiles.networking
    profiles.users.root # make sure to configure ssh keys
    profiles.users.bootstrap
  ];
  system.stateVersion = "22.11";

  boot.loader.systemd-boot.enable = true;

  # Required, but will be overridden in the resulting installer ISO.
  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
}
