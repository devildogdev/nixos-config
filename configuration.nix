{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  networking = {
    networkmanager.enable = true;
    hostName = "hackpad";
  };

  time.timeZone = "America/Chicago";

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  security.pam.services.waylock = {};

  services = {
    libinput.enable = true;
    getty.autologinUser = "devildogdev";
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  users.users.devildogdev = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  programs = {
    firefox.enable = true;
    zsh.enable = true;
    git.enable = true;
    river-classic.enable = true;
    waybar.enable = true;
  };

  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      vim
    ];
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "25.11";
}

