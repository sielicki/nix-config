{ self, config, lib, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Recreate /run/current-system symlink after boot
  services.activate-system.enable = true;

  services.nix-daemon.enable = true;

  environment = {
    systemPackages = with pkgs; [

    ];
  };

  nix = {
    settings = {
      trusted-users = [ "@admin" ];
      allowed-users = [ "@wheel" "@admin" "root" ];
    };
    configureBuildUsers = true;
    useDaemon = true;
  };

  fonts.fonts = with pkgs; [ powerline-fonts dejavu_fonts nerdfonts noto-fonts noto-fonts-emoji ];
  fonts = {
    fontDir.enable = true;
  };
}
