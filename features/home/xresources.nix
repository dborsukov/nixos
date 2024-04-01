{ config, ... }: {
  xresources.properties =
    let
      palette = config.colorscheme.palette;
    in
    {
      "*font" = "${config.fontProfiles.sans.family}:size=9";
      "*foreground" = "#${palette.base05}";
      "*background" = "#${palette.base00}";
      "*cursorColor" = "#${palette.base05}";
      "*color0" = "#${palette.base00}";
      "*color1" = "#${palette.base08}";
      "*color2" = "#${palette.base0B}";
      "*color3" = "#${palette.base0A}";
      "*color4" = "#${palette.base0D}";
      "*color5" = "#${palette.base0E}";
      "*color6" = "#${palette.base0C}";
      "*color7" = "#${palette.base05}";
      "*color8" = "#${palette.base03}";
      "*color9" = "#${palette.base09}";
      "*color10" = "#${palette.base01}";
      "*color11" = "#${palette.base02}";
      "*color12" = "#${palette.base04}";
      "*color13" = "#${palette.base06}";
      "*color14" = "#${palette.base0F}";
      "*color15" = "#${palette.base07}";
    };
}
