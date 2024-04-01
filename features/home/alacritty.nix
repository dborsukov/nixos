{ config, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 13;
        normal = {
          family = config.fontProfiles.monospace.family;
          style = "Regular";
        };
      };
      colors =
        let
          palette = config.colorscheme.palette;
        in
        {
          primary = {
            background = "#${palette.base00}";
            foreground = "#${palette.base05}";
          };
          cursor = {
            text = "#${palette.base00}";
            cursor = "#${palette.base05}";
          };
          normal = {
            black = "#${palette.base00}";
            red = "#${palette.base08}";
            green = "#${palette.base0B}";
            yellow = "#${palette.base0A}";
            blue = "#${palette.base0D}";
            magenta = "#${palette.base0E}";
            cyan = "#${palette.base0C}";
            white = "#${palette.base05}";
          };
          bright = {
            black = "#${palette.base03}";
            red = "#${palette.base09}";
            green = "#${palette.base01}";
            yellow = "#${palette.base02}";
            blue = "#${palette.base04}";
            magenta = "#${palette.base06}";
            cyan = "#${palette.base0F}";
            white = "#${palette.base07}";
          };
        };
    };
  };
}
