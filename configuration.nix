{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hackpad";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;
  services.getty.autologinUser = "devildogdev";

  users.users.devildogdev = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.river-classic.enable = true;
  programs.waybar.enable = true;
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
          IdentityFile ~/.ssh/github
    '';
  };

  environment.pathsToLink = [ "/share/zsh" ];
  environment.systemPackages = with pkgs; [
    vim
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}

