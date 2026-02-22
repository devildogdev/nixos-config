{ config, lib, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    kernelParams = [
      "mem_sleep_default=s2idle"
    ];
  };

  networking = {
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
	  EnableNetworkConfiguration = true;
	};
	Network = {
	  NameResolvingService = "resolvconf";
	};
      };
    };
    dhcpcd.enable = false;
    hostName = "hackpad";
  };

  time.timeZone = "America/Chicago";

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  security.pam.services.waylock = {};

  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=no
    HibernateDelaySec=0
    SuspendState=freeze
  '';

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
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];

  programs = {
    dconf.enable = true;
    git.enable = true;
    steam.enable = true;
    zsh.enable = true;
  };

  environment = {
    pathsToLink = [
      "/share/zsh"
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
    systemPackages = [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
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

