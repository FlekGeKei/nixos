{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mainMod" = "SUPER";
       
      monitor = ",preferred,auto,1";

      env = [
        "XDG_CURRENT_DESCTOP,Hyprland"
	"XDG_SESSION_TYPE,wayland"
	"XDG_SESSION_DESCTOP,Hyprland"
	"XCURSOR_SIZE,22"
	"QT_QPA_PLATFORM,wayland"
	"QT_QPA_PLATFORME,gtk2"
	"GTK_THEME,Breeze-Dark"
	"ELECTRON_OZONE_PLATFORM_HINT,wayland"
      ];

      input = {
        kb_layout = "us,ru";
        kb_variant = "lang";
        kb_options = "grp:caps_toggle";

	follow_mouse = 1;

	force_no_accel = true;
	accel_profile = "flat";

	touchpad = {
          natural_scroll = false;
	  disable_while_typing = false;
	};

	sensitivity = 0;
      };

      general = {
        gaps_in = 2;
	gaps_out = 2;
	border_size = 1;
	"col.active_border" = "rgba(3daee9ee)";
	"col.inactive_border" = "rgba(4d4d4dee)";

	layout = "dwindle";
      };

      decoration = {
        rounding = 2;

	blur = {
	  enabled = true;
	  size = 16;
	  passes = 2;
          new_optimizations = true;
	};

        drop_shadow = true;
	shadow_range = 4;
	shadow_render_power = 3;
	"col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        # bezier = "myBezier, 0.33, 0.82, 0.9, -0.08";

        animation = [
          "windows,     1, 7,  myBezier"
          "windowsOut,  1, 7,  default, popin 80%"
          "border,      1, 10, default"
          "borderangle, 1, 8,  default"
          "fade,        1, 7,  default"
          "workspaces,  1, 6,  default"
        ];
      };
      
      dwindle = {
        pseudotile = true;
	preserve_split = true;
      };

      gestures = {
        workspace_swipe = true;
	workspace_swipe_fingers = 3;
	workspace_swipe_invert = false;
	workspace_swipe_distance = 200;
	workspace_swipe_forever = true;
      };

      misc = {
        animate_manual_resizes = true;
	animate_mouse_windowdragging = true;
	enable_swallow = true;
	render_ahead_of_time = false;
	disable_hyprland_logo = true;
      };

      windowrule = [
	"workspace 7, ^(qbittorrent)$"
	"workspace 8, ^(vesktop)$"
	"workspace 8, ^(Discord)$"
	"workspace 1, ^(kitty)$"
	"workspace 2, ^(Vivaldi-stable)$"
      ];

      windowrulev2 = [
	"float,class:^(Vivaldi-stable)$,title:^(Vivaldi - Login - Vivaldi)$"
	"size 310 590,class:^(Vivaldi-stable)$,title:^(Vivaldi - Login - Vivaldi)$"
	"float,class:^(steam)$,title:^(Steam Settings)$"
	"float,class:^(steam)$,title:^(Friends List)$"
	"size 384 856,class:^(steam)$,title:^(Friends List)$"
	"stayfocused, title:^()$,class:^(steam)$"
	"minsize 1 1, title:^()$,class:^(steam)$"
	"stayfocused, title:^()$,class:^(waybar)$"
	"minsize 1 1, title:^()$,class:^(waybar)$"
      ];

      exec-once = [
        "waybar"
	"udiskie -s"
	"wl-paste --type text --watch cliphist store"
	"wl-paste --type image --watch cliphist store"
      ];

      bind = [ 
        "$mainMod, Return, exec, kitty"
        "$mainMod, C, killactive,"
	"$mainMod SHIFT, Q, exit,"
	"$mainMod, R, exec, bemenu-run -H 25"
	"$mainMod, space, togglefloating,"
	"$mainMod, F, fullscreen,"
	"$mainMod, Print, exec, grim -g \"$(slurp)\" ~/Pictures/Screenshots/screen-$(date +%s).png"
	", Print, exec, grim ~/Pictures/Screenshots/screen-$(date +%s).png"
	"$mainMod, V, exec, cliphist list | bemenu -H 25 | cliphist decode | wl-copy"

        # Move focus with mainMod + arrow keys
        "$mainMod, l,  movefocus, l"
        "$mainMod, h,  movefocus, r"
        "$mainMod, j,  movefocus, u"
        "$mainMod, k,  movefocus, d"

        # Moving windows
        "$mainMod SHIFT, l, swapwindow, l"
        "$mainMod SHIFT, h, swapwindow, r"
        "$mainMod SHIFT, j, swapwindow, u"
        "$mainMod SHIFT, k, swapwindow, d"

        # Window resizing                  X  Y
        "$mainMod CTRL, l,  resizeactive, -60 0"
        "$mainMod CTRL, h,  resizeactive,  60 0"
        "$mainMod CTRL, j,  resizeactive,  0 -60"
        "$mainMod CTRL, k,  resizeactive,  0  60"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Volume and Media Control
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
        
        # Brightness control
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%- "
        ", XF86MonBrightnessUp, exec, brightnessctl set +5% "
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
