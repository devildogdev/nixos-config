{ config, pkgs, ... }:

{
  wayland.windowManager.river = {
    enable = true;
    systemd.enable = true;
    extraSessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
    settings = {
      background-color = "0x000000";
      border-color-focused = "0x74c7ec";
      border-color-unfocused = "0x313244";
      set-repeat = "35 200";
      default-layout = "rivertile";
      declare-mode = "passthrough";
      map = {
        normal = {
	  "Super+Shift Return" = "spawn footclient";
	  "Super D" = "spawn 'fuzzel -d'";
	  "Super Q" = "close";
	  "Super+Shift E" = "exit";
	  "Super J" = "focus-view next";
	  "Super K" = "focus-view previous";
	  "Super+Shift J" = "swap next";
	  "Super+Shift K" = "swap previous";
	  "Super Period" = "focus-output next";
	  "Super Comma" = "focus-output previous";
	  "Super+Shift Period" = "send-to-output next";
	  "Super+Shift Comma" = "send-to-output previous";
	  "Super Return" = "zoom";
	  "Super H" = "send-layout-cmd rivertile 'main-ratio -0.05'";
	  "Super L" = "send-layout-cmd rivertile 'main-ratio +0.05'";
	  "Super+Shift H" = "send-layout-cmd rivertile 'main-count +1'";
	  "Super+Shift L" = "send-layout-cmd rivertile 'main-count -1'";
	  "Super+Alt H" = "move left 100";
	  "Super+Alt J" = "move down 100";
	  "Super+Alt K" = "move up 100";
	  "Super+Alt L" = "move right 100";
	  "Super+Alt+Control H" = "snap left";
	  "Super+Alt+Control J" = "snap down";
	  "Super+Alt+Control K" = "snap up";
	  "Super+Alt+Control L" = "snap right";
	  "Super+Alt+Shift H" = "resize horizontal -100";
	  "Super+Alt+Shift J" = "resize vertical 100";
	  "Super+Alt+Shift K" = "resize vertical -100";
	  "Super+Alt+Shift L" = "resize horizontal 100";
	  "Super Space" = "toggle-float";
	  "Super F" = "toggle-fullscreen";
	  "Super Up" = "send-layout-cmd rivertile 'main-location top'";
	  "Super Right" = "send-layout-cmd rivertile 'main-location right'";
	  "Super Down" = "send-layout-cmd rivertile 'main-location bottom'";
	  "Super Left" = "send-layout-cmd rivertile 'main-location left'";
	  "Super F11" = "enter-mode passthrough";
	};
	passthrough = {
	  "Super F11" = "enter-mode normal";
	};
      };
      map-pointer = {
        normal = {
	  "Super BTN_LEFT" = "move-view";
          "Super BTN_RIGHT" = "resize-view";
          "Super BTN_MIDDLE" = "toggle-float";
	};
      };
    };
    extraConfig = ''
      for i in $(seq 1 9)
      do
          tags=$((1 << ($i - 1)))
      
          # Super+[1-9] to focus tag [0-8]
          riverctl map normal Super $i set-focused-tags $tags
      
          # Super+Shift+[1-9] to tag focused view with tag [0-8]
          riverctl map normal Super+Shift $i set-view-tags $tags
      
          # Super+Control+[1-9] to toggle focus of tag [0-8]
          riverctl map normal Super+Control $i toggle-focused-tags $tags
      
          # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
          riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
      done
      
      all_tags=$(((1 << 32) - 1))
      riverctl map normal Super 0 set-focused-tags $all_tags
      riverctl map normal Super+Shift 0 set-view-tags $all_tags

      for mode in normal locked
      do
          riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
          riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5'
          riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute'
      
          riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
          riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
          riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
          riverctl map $mode None XF86AudioNext  spawn 'playerctl next'
      
          riverctl map $mode None XF86MonBrightnessUp   spawn 'brightnessctl set +5%'
          riverctl map $mode None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'
      done

      rivertile -view-padding 5 -outer-padding 5 &

      swaybg -i ~/pics/wallpaper.jpg &
    '';
  };
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 30;
        spacing = 4;
        modules-left = [
          "river/tags"
          "river/mode"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "network"
          "cpu"
          "temperature"
          "memory"
          "battery"
        ];
        "river/tags" = {
          num-tags = 5;
        };
        tray = {
            spacing = 10;
        };
        network = {
            format-wifi = "";
            format-ethernet = "";
            tooltip = "false";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        cpu = {
            format = "{usage}% ";
            tooltip = "false";
        };
        temperature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = [ "" "" "" ];
        };
        memory = {
            format = "{}% ";
        };
        battery = {
            states = {
                warning = 30;
                critical = 15;
            };
            format = "{capacity}% {icon}";
            format-full = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = [ "" "" "" "" "" ];
        };
        clock =  {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
        };
      };
    };
    style = ''
      * {
        font-family: monospace;
        font-size: 16px;
      }
      
      window#waybar {
        background-color: #000000;
      }
      
      #tags {
        background-color: transparent;
      }
      
      #tags button {
        padding: 0 5px;
        background-color: transparent;
        color: #cdd6f4;
        border: none;
        border-radius: 0;
        box-shadow: none;
      }
      
      #workspaces button.occupied {
        color: #cdd6f4;
      }
      
      #tags button.focused {
        color: #cba6f7;
        box-shadow: inset 0 -3px #cba6f7;
      }
      
      #tags button.urgent {
        color: #fab387;
      }
      
      #tray,
      #network,
      #temperature,
      #cpu,
      #memory,
      #battery,
      #clock {
        padding: 0 10px;
      }
      
      #window,
      #tags {
        margin: 0 4px;
      }
      
      .modules-left > widget:first-child > #tags {
        margin-left: 0;
      }
      
      #clock {
        color: #cdd6f4;
      }
      
      #battery {
        color: #a6e3a1;
        border-bottom: 2px solid #a6e3a1;
      }
      
      #battery.charging, #battery.plugged {
        color: #a6e3a1;
        border-bottom: 2px solid #a6e3a1;
      }
      
      /* Using steps() instead of linear as a timing function to limit cpu usage */
      #battery.critical:not(.charging) {
        color: #f38ba8;
        border-bottom: 2px solid #f38ba8;
      }
      
      #network {
        color: #89b4fa;
        border-bottom: 2px solid #89b4fa;
      }
      
      #network.disconnected {
        color: #f38ba8;
        border-bottom: 2px solid #f38ba8;
      }
      
      #temperature {
        color: #f9e2af;
        border-bottom: 2px solid #f9e2af;
      }
      
      #temperature.critical {
        color: #f38ba8;
        border-bottom: 2px solid #f38ba8;
      }
      
      #cpu {
        color: #f5c2e7;
        border-bottom: 2px solid #f5c2e7;
      }
      
      #memory {
        color: #fab387;
        border-bottom: 2px solid #fab387;
      }
      
      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eba0ac;
      }
    '';
    systemd.enable = true;
  };
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "Hack Nerd Font Mono:size=13";
	pad = "5x5 center-when-maximized-and-fullscreen";
      };
      colors = {
        cursor = "11111b f5e0dc";
        foreground = "cdd6f4";
        background = "000000";
        regular0 = "45475a";
        regular1 = "f38ba8";
        regular2 = "a6e3a1";
        regular3 = "f9e2af";
        regular4 = "89b4fa";
        regular5 = "f5c2e7";
        regular6 = "94e2d5";
        regular7 = "bac2de";
        bright0 = "585b70";
        bright1 = "f38ba8";
        bright2 = "a6e3a1";
        bright3 = "f9e2af";
        bright4 = "89b4fa";
        bright5 = "f5c2e7";
        bright6 = "94e2d5";
        bright7 = "a6adc8";
        "16" = "fab387";
        "17" = "f5e0dc";
        selection-foreground = "cdd6f4";
        selection-background = "414356";
        search-box-no-match = "11111b f38ba8";
        search-box-match = "cdd6f4 313244";
        jump-labels = "11111b fab387";
        urls = "89b4fa";
      };
      bell.system = "no";
      mouse.hide-when-typing = true;
    };
  };
  programs.fuzzel.enable = true;
  services.mako = {
    enable = true;
    extraConfig = ''
      [urgency=high]
      border-color=#fab387
    '';
    settings = {
      background-color = "#000000";
      text-color = "#cdd6f4";
      border-color = "#74c7ec";
      progress-color = "over #313244";
    };
  };
  services.kanshi = {
    enable = true;
    profiles = {
      docked = {
        outputs = [
	  {
	    criteria = "eDP-1";
	    status = "disable";
	  }
	  {
	    criteria = "HDMI-A-1";
	  }
	];
      };
      undocked = {
        outputs = [
	  {
	    criteria = "eDP-1";
	  }
	];
      };
    };
  };
}

