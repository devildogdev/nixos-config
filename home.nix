{ config, pkgs, ... }:

{
  imports = [
    ./modules/desktop.nix
    ./modules/editor.nix
    ./modules/shell.nix
  ];

  home = {
    username = "devildogdev";
    homeDirectory = "/home/devildogdev";
    stateVersion = "25.11";
    packages = with pkgs; [
      btop
      swaybg
      waylock
      grim
      slurp
      wl-clipboard
      xdg-desktop-portal-wlr
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
