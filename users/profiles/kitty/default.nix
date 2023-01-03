{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = false;
    theme = "Highway";
    environment = {
      COLORTERM = "truecolor";
    };
    settings = {
      copy_on_select = true;
      enable_audio_bell = false;
    };
  };
}
