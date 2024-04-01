{ pkgs, config, ... }: {
  services.dunst = {
    enable = true;
    settings =
      let
        palette = config.colorscheme.palette;
      in
      {
        global = {
          height = 200;
          width = "(100, 400)";
          offset = "10x10";
          origin = "top-right";
          font = "${config.fontProfiles.sans.family} 10";
          frame_width = 2;
          frame_color = "#${palette.base05}";
          separator_color = "#${palette.base05}";
        };
        urgency_low = {
          foreground = "#${palette.base06}";
          background = "#${palette.base02}";
        };
        urgency_normal = {
          foreground = "#${palette.base05}";
          background = "#${palette.base01}";
        };
        urgency_critical = {
          foreground = "#${palette.base01}";
          background = "#${palette.base08}";
        };
      };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
}
