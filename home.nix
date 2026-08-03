{ config, pkgs, ... }:

{
  imports = [
    ./modules/desktop
    ./modules/editor
    ./modules/terminal
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      documents = "${config.home.homeDirectory}/docs";
      download = "${config.home.homeDirectory}/dl";
      music = null;
      pictures = "${config.home.homeDirectory}/pics";
      projects = "${config.home.homeDirectory}/repos";
      publicShare = null;
      templates = null;
      videos = null;
    };
    portal = {
      enable = true;
      extraPortals = with pkgs;[
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      config = {
        river = {
          default = [ "gtk" ];
            "org.freedesktop.impl.portal.Screenshot" = "wlr";
            "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        };
      };
    };
  };

  home = {
    username = "devildogdev";
    homeDirectory = "/home/devildogdev";
    stateVersion = "26.05";
    sessionVariables = {
      LESSHISTFILE = "-";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "river";
    };
    packages = with pkgs; [
      swaybg
      waylock
      grim
      slurp
      gcc
      go
      zig
      wl-clipboard
      brightnessctl
      gimp
      ffmpeg
      bitwarden-cli
      cura-appimage
    ];
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  services.ssh-agent.enable = true;

  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "devildogdev";
          email = "justinrtew@gmail.com";
        };
      };
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "github.com" = {
          user = "git";
          identityFile = "~/.ssh/github";
          addKeysToAgent = "yes";
        };
      };
    };
  };
}
