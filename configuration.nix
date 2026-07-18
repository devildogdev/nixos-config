{ lib, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
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
    noto-fonts
    nerd-fonts.hack
  ];

  security = {
    pam.services.waylock = {};
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          // Actions we care about
          const actions = [
            "org.freedesktop.login1.suspend",
            "org.freedesktop.login1.suspend-multiple-sessions",
            "org.freedesktop.login1.reboot",
            "org.freedesktop.login1.reboot-multiple-sessions",
            "org.freedesktop.login1.power-off",
            "org.freedesktop.login1.power-off-multiple-sessions"
          ];

          if (actions.indexOf(action.id) !== -1) {
            // Only allow for local, active sessions (not remote/SSH)
            if (subject.isInGroup("wheel") && subject.isActive) {
              return polkit.Result.YES;
            }
          }
        });
      '';
    };
  };

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

  system.stateVersion = "26.05";
}

