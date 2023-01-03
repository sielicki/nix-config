{ self, config, lib, pkgs, ... }:
{
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;
  hardware.pulseaudio.support32Bit = true;
  environment.systemPackages = with pkgs; [
    steam
    steam-tui
    steamcmd
  ];
}
