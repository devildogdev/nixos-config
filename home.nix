{ config, pkgs, ... }:

{
  imports = [
    ./modules/desktop
    ./modules/editor
    ./modules/terminal
  ];

  xdg.portal = {
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

  home = {
    username = "devildogdev";
    homeDirectory = "/home/devildogdev";
    stateVersion = "25.11";
    sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "river";
    };
    packages = with pkgs; [
      btop
      swaybg
      waylock
      grim
      slurp
      wl-clipboard
    ];
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
      matchBlocks = {
        "github.com" = {
	  user = "git";
	  identityFile = "~/.ssh/github";
	  addKeysToAgent = "yes";
	};
      };
    };
  };
}
