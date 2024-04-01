{ pkgs, config, ... }: {
  services.polybar = {
    enable = true;
    script = "polybar main &";
    package = pkgs.polybarFull;
    settings =
      let
        palette = config.colorscheme.palette;
      in
      {
        "settings" = {
          screenchange-reload = true;
        };
        "bar/main" = {
          width = "100%";
          height = "16pt";
          bottom = true;
          enable-ipc = true;
          wm-restack = "bspwm";
          separator = "|";
          padding-left = 0;
          padding-right = 2;
          module-margin = 2;
          border-top-size = 1;
          cursor-click = "pointer";
          modules-left = "workspaces";
          modules-right = "cpu memory filesystem audio date time tray";
          font = [ "${config.fontProfiles.sans.family}:size=9;2" "Font Awesome 6 Free Solid:size=8;3" ];
          background = "#${palette.base00}";
          foreground = "#${palette.base05}";
          border-color = "#${palette.base01}";
          separator-foreground = "#${palette.base01}";
        };
        "module/workspaces" = {
          type = "internal/bspwm";
          enable-scroll = false;
          format = "<label-state>";
          label = {
            focused = {
              text = "%name%";
              padding = 2;
              background = "#${palette.base01}";
            };
            occupied = {
              text = "%name%";
              padding = 2;
              background = "#${palette.base00}";
            };
            urgent = {
              text = "%name%";
              padding = 2;
              foreground = "#${palette.base00}";
              background = "#${palette.base09}";
            };
            empty = {
              text = "";
              padding = 0;
            };
          };
        };
        "module/cpu" = {
          type = "internal/cpu";
          interval = 2;
          warn.percentage = 90;
          label = {
            text = "%percentage%%";
            warn.text = "%percentage%%";
          };
          format = {
            text = "<label>";
            prefix = {
              text = " ";
              foreground = "#${palette.base08}";
            };
          };
          format.warn = {
            text = "<label-warn>";
            foreground = "#${palette.base0A}";
            prefix = {
              text = " ";
              foreground = "#${palette.base0A}";
            };
          };
        };
        "module/memory" = {
          type = "internal/memory";
          interval = 2;
          warn.percentage = 75;
          label = {
            text = "%percentage_used%%";
            warn.text = "%percentage_used%%";
          };
          format = {
            text = "<label>";
            prefix = {
              text = " ";
              foreground = "#${palette.base08}";
            };
          };
          format.warn = {
            text = "<label-warn>";
            foreground = "#${palette.base09}";
            prefix = {
              text = " ";
              foreground = "#${palette.base09}";
            };
          };
        };
        "module/filesystem" = {
          type = "internal/fs";
          interval = 25;
          mount = [ "/" ];
          label.mounted = "%free%";
          format.mounted = {
            text = "<label-mounted>";
            prefix = {
              text = " ";
              foreground = "#${palette.base08}";
            };
          };
        };
        "module/audio" = {
          type = "internal/pulseaudio";
          label = {
            volume.text = "%percentage%%";
            muted.text = " ";
          };
          format.volume = {
            text = "<label-volume>";
            prefix = {
              text = " ";
              foreground = "#${palette.base08}";
            };
          };
          format.muted = {
            text = "<label-muted>";
            foreground = "#${palette.base0A}";
          };
        };
        "module/date" = {
          type = "internal/date";
          interval = 1;
          date = "%Y-%m-%d";
          label = "%date%";
          format = {
            text = "<label>";
            prefix = {
              text = " ";
              foreground = "#${palette.base08}";
            };
          };
        };
        "module/time" = {
          type = "internal/date";
          interval = 1;
          time = "%H:%M:%S";
          label = "%time%";
          format = {
            text = "<label>";
            prefix = {
              text = " ";
              foreground = "#${palette.base08}";
            };
          };
        };
        "module/tray" = {
          type = "internal/tray";
          format.margin = "2pt";
          tray = {
            size = "68%";
            spacing = "2pt";
          };
        };
      };
  };
}
