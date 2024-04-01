{ pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./features/system
  ];

  networking = {
    hostName = "oberon";
    useDHCP = true;
  };

  users.users = {
    "db" = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [
        "audio"
        "video"
        "wheel"
        "networkmanager"
        "scanner"
        "lp"
      ];
    };
  };

  programs = {
    fish.enable = true;
    dconf.enable = true;
    ssh.startAgent = true;
    gnupg.agent.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };
  };

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 28;
      resolutions = [
        {
          x = 1920;
          y = 1080;
        }
      ];
      displayManager = {
        lightdm = {
          enable = true;
          greeters.slick.enable = true;
        };
        defaultSession = "none+bspwm";
      };
      windowManager.bspwm.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    home-manager
    libnotify
    xclip
  ];

  hardware =
    {
      opengl.enable = true;
      opengl.driSupport = true;
      opengl.driSupport32Bit = true;
    };

  # Do not change
  system.stateVersion = "23.11";
}
