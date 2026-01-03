{ config, pkgs, ... }:

{
  services = {
    mako = {
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
    kanshi = {
      enable = true;
      settings = [
        {
          profile = {
            name = "docked";
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
        }
        {
          profile = {
            name = "undocked";
            outputs = [
              {
                criteria = "eDP-1";
              }
            ];
          };
        }
      ];
    };
    swayidle = {
      enable = true;
      events = {
        before-sleep = "${pkgs.waylock}/bin/waylock -init-color 0x000000 -input-color 0x11111b -ignore-empty-password";
      };
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.waylock}/bin/waylock -init-color 0x000000 -input-color 0x11111b -ignore-empty-password";
        }
      ];
    };
  };
}
