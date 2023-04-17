{ self, config, lib, pkgs, ... }:
{
  services.yabai = {
    enable = false;
    config = {
	    mouse_follows_focus         =  "off";
	    focus_follows_mouse         =  "off";
	    window_origin_display       =  "default";
	    window_placement            =  "second_child";
	    window_zoom_persist         =  "on";
	    window_topmost              =  "off";
	    window_shadow               =  "on";
	    window_animation_duration   =  "0.0";
	    window_animation_frame_rate =  "120";
	    window_opacity_duration     =  "0.0";
	    active_window_opacity       =  "1.0";
	    normal_window_opacity       =  "0.90";
	    window_opacity              =  "off";
	    insert_feedback_color       =  "0xffd75f5f";
	    active_window_border_color  =  "0xff775759";
	    normal_window_border_color  =  "0xff555555";
	    window_border_width         =  "4";
	    window_border_radius        =  "12";
	    window_border_blur          =  "off";
	    window_border_hidpi         =  "on";
	    window_border               =  "off";
	    split_ratio                 =  "0.50";
	    split_type                  =  "auto";
	    auto_balance                =  "off";
	    top_padding                 =  "12";
	    bottom_padding              =  "12";
	    left_padding                =  "12";
	    right_padding               =  "12";
	    window_gap                  =  "06";
	    layout                      =  "bsp";
	    mouse_modifier              =  "fn";
	    mouse_action1               =  "move";
	    mouse_action2               =  "resize";
	    mouse_drop_action           =  "swap";
    };
  };

  services.skhd = {
    enable = false;
    skhdConfig = ''
      ctrl - e : yabai -m space --layout bsp
      ctrl - s : yabai -m space --layout stack

      # change focus
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east
      # (alt) change focus (using arrow keys)
      alt - left  : yabai -m window --focus west
      alt - down  : yabai -m window --focus south
      alt - up    : yabai -m window --focus north
      alt - right : yabai -m window --focus east 
      
      ctrl - 1 : yabai -m space --focus 1
      ctrl - 2 : yabai -m space --focus 2
      ctrl - 3 : yabai -m space --focus 3
      ctrl - 4 : yabai -m space --focus 4
      ctrl - 5 : yabai -m space --focus 5
      ctrl - 6 : yabai -m space --focus 6
      
      ctrl + shift - 1 : yabai -m window --space 1
      ctrl + shift - 2 : yabai -m window --space 2
      ctrl + shift - 3 : yabai -m window --space 3
      ctrl + shift - 4 : yabai -m window --space 4
      ctrl + shift - 5 : yabai -m window --space 5
      ctrl + shift - 6 : yabai -m window --space 6
      
      ctrl - f : yabai -m window --toggle float
    '';
  };
}
