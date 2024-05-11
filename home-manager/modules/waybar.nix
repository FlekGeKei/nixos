{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        height = 25;
        modules-left = [
          "hyprland/workspaces"
          "mpd"
        ];
        modules-center = [];
        modules-right = [
          "tray"
          "hyprland/language"
          "network"
          "temperature"
          "cpu"
          "custom/iris"
          "memory"
          "battery"
          "backlight"
          "battery#bat2"
          "wireplumber"
          "clock"
        ];

	"custom/iris" = {
	  format = "{}%  ";
  	  interval = "10";
	  tooltip = true;
	  return-type = "json";
	  exec = "~/.config/home-manager/modules/ws/iris.sh";
	};

	"hyprland/workspaces" = {
	  persistent-workspaces = {
	    "*" = 10;
	  };
	};

	"memory" = {
	 interval = 30;
	 format = " {used}G  ";
	 max-length = 10;
	};

	"network" = {
	  #interface = "wlp2*";
	  format-wifi = " {signalStrength}% {icon} ";
	  format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
	  tooltip-format = "{essid} {ifname} via {gwaddr}  ";
	  format-disconnected = " ";
	  interval = "10";
	};
	
	"backlight" = {
	  device = "intel_backlight";
	  format = "{percent}% {icon} ";
	  format-icons = ["" "" "" "" "" "" "" "" ""];
	};

	"battery" = {
	  format = " {capacity}% {icon} ";
	  format-charging = " {capacity}%  ";
	  format-plugged = " {capacity}%  ";
	  format-alt = " {time} {icon} ";
	  format-icons = ["" "" "" "" ""];
	};

	"battery#bat2" = {
	  bat = "BAT2";
	};

	"hyprland/language" = {
	  format = " {}  ";
	  format-en = "US";
	  format-ru = "RU";
	  keyboard-name = "at-translated-set-2-keyboard";
	};

	"clock" = {
	  format = "{:%I:%M %p}  ";
	  tooltip-format = "<tt><small>{calendar}</small></tt>";
	  locale = "ru_RU.UTF-8";
	  calendar = {
	    mode = "mode";
	    mode-mon-col = 3;
	    wiiks-pos = "right";
	    on-scroll = 1;
	    format = {
	      monts = "<span color='#ffead3'><b>{}</b></span>";
	      days = "<span color='#ecc6d9'><b>{}</b></span>";
	      weeks = "<span color='#99ffdd'><b>W{}</b></span>";
	      weekdays = "<span color='#ffcc66'><b>{}</b></span>";
	      today = "<span color='#ff6699'><b><u>{}</u></b></span>";
	    };
	  };
	  actions = {
	    on-click-right = "mode";
	    on-click-forward = "tz_up";
	    on-click-backward = "tz_down";
	    on-scroll-up = "shift_up";
	    on-scroll-down = "shift_down";
	  };
	};

	"tray" = {
	  icon-size = 20;
	  spacing = 10;
	};

	"mpd" = {
	  server = "localhost";
	  port = "6600";
	  format = "{stateIcon} {consumeIcon}{singleIcon} {artist} - {title} ";
	  format-disconnected = "Disconnected ";
	  format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped";
	  interval = 10;
	  on-click = "mpc toggle";
	  on-click-right = "mpc next";
	  on-scroll-up = "mpc volume +1";
	  on-scroll-down = "mpc volume -1";
	  consume-icons = {
	    on = " ";
	  };
	  random-icons = {
	    off = "<span color=\"#f53c3c\"></span> ";
	    on = " ";
	  };
	  repeat-icons = {
	    on = " ";
	  };
	  single-icons = {
	    on = " 1 ";
	  };	
	  state-icons = {
	    paused = "";
	    playing = "";
	  };
	  tooltip-format = "MPD {elapsedTime:%M:%S}/{totalTime:%M:%S}";
	  tooltip-format-disconnected = "MPD (disconnected)";
	};

	"cpu" = {
	  format = " {usage}%  ";
	  tooltip = true;
	};

	"temperature" = {
	  critical-threshold = 80;
	  format = "{temperatureC}°C {icon}";
	  format-icons = ["" "" "" ""];
	};

	"wireplumber" = {
	  format = "{volume}% {icon} ";
	  format-muted = " ";
	  on-click = "pavucontrol";
	  max-volume = 150;
	  scroll-step = 1;
	  format-icons = ["" "" ""];
	};
      };
    };

    style = 
      ''
	* {
	  font-family: Noto Sans;
	  font-size: 16px;
	  padding-top: 0;
	  padding-bottom: 0;
	}

	window#waybar {
	  background-color: #3f3f3f;
	}

	window#waybar.hidden {
	  opacity: 0.2;
	}

	/*
	window#waybar.empty {
	  background-color: transparent;
	}
	window#waybar.solo {
	  background-color: #FFFFFF;
	}
	*/

	window#waybar.termite {
	  background-color: #3F3F3F;
	}

	#custom-iris {
	  color: #ffffff;
	  background-color: #3f3f3f;
	}

	#language {
	  background-color: #3F3F3F;
	  color: #FFFFFF;
	}

	#mpd {
	  background-color: #3F3F3F;
	  color: #FFFFFF;
	}

	#tray {
	  background-color: #3F3F3F;
	  color: #FFFFFF;
	}

	#language {
	  background-color: #3F3F3F;
	  color: #FFFFFF;
	}

	#network {
	  background-color: #3F3F3F;
	  color: #FFFFFF;
	}

	#battery {
	  background-color: #3F3F3F;
	  color: #FFFFFF;
	}

	#backlight {
	  background-color: #3F3F3F;
	  color: #FFFFFF;
	}

	#wireplumber {
	  background-color: #3F3F3F;
	  color: #FFFFFF;
	}

	#clock {
          background-color: #3F3F3F;
	  color: #FFFFFF;
	}

	#workspaces {
	  background-color: #3f3f3f;
	  color: #ffffff;
	}

	#workspaces button {
	  background-color: #3f3f3f;
	  color: #ffffff;
	}

	#workspaces button.active {
	  box-shadow: inset 0 -3px #ffffff;
	  color: #ffffff;
	  background-color: #3f3f3f;
	}

	#workspaces button.empty {
	  background-color: #3F3F3F;
	  color: #FFFFFF;
	}

	#workspaces button.persistent {
	  background-color: #3F3F3F;
	  color: #FFFFFF;
	}

	#workspaces button.special {
	  background-color: #3F3F3F;
	  color: #FFFFFF;
	}

	#workspaces button.visible {
	  color: #ffffff;
	  background-color: #3f3f3f;
	}

	#cpu {
	  color: #ffffff;
	  background-color: #3f3f3f;
	}

	#memory {
	  color: #ffffff;
	  background-color: #3f3f3f;
	}

	#temperature {
	  color: #ffffff;
	  background-color: #3f3f3f;
	}
    '';
  };
}
