{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        height = 30;
        spacing = 4;
        modules-left = [
          "river/tags"
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
          disable-click = true;
        };
        tray = {
            spacing = 10;
        };
        network = {
            format-wifi = "";
            format-ethernet = "";
            tooltip = "false";
              format-linked = "{ifname} (No IP)";
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
            format-icons = [ "" "" "" ];
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
            format-charging = "{capacity}% ";
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
        color: #313244;
        border: none;
        border-radius: 0;
        box-shadow: none;
      }

      #tags button:hover {
        background: inherit;
        box-shadow: inherit;
        text-shadow: inherit;
      }

      #tags button.occupied {
        color: #cdd6f4;
      }

      #tags button.focused {
        color: #cba6f7;
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
      }

      #battery.charging, #battery.plugged {
        color: #a6e3a1;
      }

      #battery.critical:not(.charging) {
        color: #f38ba8;
      }

      #network {
        color: #89b4fa;
      }

      #network.disconnected {
        color: #f38ba8;
      }

      #temperature {
        color: #f9e2af;
      }

      #temperature.critical {
        color: #f38ba8;
      }

      #cpu {
        color: #f5c2e7;
      }

      #memory {
        color: #fab387;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eba0ac;
      }
    '';
  };
}

