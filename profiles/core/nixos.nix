{ config, lib, pkgs, self, ... }:

{
  imports = [
    ./common.nix
  ];

  environment = {

    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      dosfstools
      gptfdisk
      iputils
      usbutils
      utillinux
    ];
  };

  users.defaultUserShell = pkgs.zsh;
  fonts.fonts = with pkgs; [ powerline-fonts dejavu_fonts nerdfonts noto-fonts noto-fonts-emoji ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "DejaVu Sans Mono for Powerline" ];
    sansSerif = [ "DejaVu Sans" ];
  };

  nix.settings = {
    system-features = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    auto-optimise-store = true;
    allowed-users = [ "@wheel" ];
  };

  # For rage encryption, all hosts need a ssh key pair
  services.openssh = {
    enable = true;
    openFirewall = lib.mkDefault false;
  };

  # Service that makes Out of Memory Killer more effective
  services.earlyoom.enable = true;

}
