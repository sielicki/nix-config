{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
        COLORTERM = "truecolor";
      };
      colors = {
        primary = {
          foreground = "0xdbdbdb";
          background = "0x14191e";
        };
        cursor = {
          text = "0x000000";
          cursor = "0xfefffe";
        };
        selection = {
          text = "0x000000";
          background = "0xb3d7ff";
        };
        normal = {
          black = "0x14191e";
          red = "0xb43c29";
          green = "0x00c200";
          yellow = "0xc7c400";
          blue = "0x2743c7";
          magenta = "0xbf3fbd";
          cyan = "0x00c5c7";
          white = "0xc7c7c7";
        };
        bright = {
          black = "0x676767";
          red = "0xdc7974";
          green = "0x57e690";
          yellow = "0xece100";
          blue = "0xa6aaf1";
          magenta = "0xe07de0";
          cyan = "0x5ffdff";
          white = "0xfeffff";
        };
      };
    };
  };
}
