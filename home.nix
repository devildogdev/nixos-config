{ config, pkgs, ... }:

{
  imports = [
    ./modules/shell.nix
    ./modules/desktop.nix
  ];
  home.username = "devildogdev";
  home.homeDirectory = "/home/devildogdev";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    btop
    swaybg
    xdg-desktop-portal-wlr
    wl-clipboard
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "devildogdev";
        email = "justinrtew@gmail.com";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
