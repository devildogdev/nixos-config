{ ... }:

{
  imports = [
    ./waybar.nix
    ./fuzzel.nix
    ./services.nix
  ];

  wayland.windowManager.river = {
    enable = true;
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
      input = {
        "pointer-2-7-SynPS/2_Synaptics_TouchPad" = {
          eventss = true;
          accel-profile = "flat";
          pointer-accel = 1.0;
          tap = true;
        };
      };
      map = {
        normal = {
          "Super+Shift Return" = "spawn footclient";
          "Super D" = "spawn fuzzel";
          "Super Q" = "close";
          "Super S" = "spawn 'grim -g \"$(slurp)\" | wl-copy'";
          "Super+Shift E" = "exit";
          "Super+Control L" = "spawn 'waylock -init-color 0x000000 -input-color 0x11111b -ignore-empty-password'";
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
      rule-add = {
        "-app-id" = {
          "'steam_app_*'" = "fullscreen";
        };
      };
    };
    extraConfig = ''
      swaybg -i ~/pics/wallpaper.jpg &

      for i in $(seq 1 9)
      do
          tags=$((1 << ($i - 1)))
          riverctl map normal Super $i set-focused-tags $tags
          riverctl map normal Super+Shift $i set-view-tags $tags
          riverctl map normal Super+Control $i toggle-focused-tags $tags
          riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
      done

      all_tags=$(((1 << 32) - 1))
      riverctl map normal Super 0 set-focused-tags $all_tags
      riverctl map normal Super+Shift 0 set-view-tags $all_tags

      for mode in normal locked
      do
          riverctl map $mode None XF86AudioRaiseVolume  spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+'
          riverctl map $mode None XF86AudioLowerVolume  spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-'
          riverctl map $mode None XF86AudioMute         spawn 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'
          riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
          riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
          riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
          riverctl map $mode None XF86AudioNext  spawn 'playerctl next'
          riverctl map $mode None XF86MonBrightnessUp   spawn 'brightnessctl set +5%'
          riverctl map $mode None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'
      done

      rivertile -view-padding 5 -outer-padding 5 &
    '';
  };
  programs = {
    imv.enable = true;
    mpv.enable = true;
    obs-studio.enable = true;
    onlyoffice.enable = true;
  };
}

