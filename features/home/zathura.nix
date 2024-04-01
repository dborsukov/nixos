{ config, ... }: {
  programs.zathura =
    let
      palette = config.colorscheme.palette;
    in
    {
      enable = true;
      options = {
        font = "${config.fontProfiles.sans.family} 12";
        recolor = "true";
        recolor-keephue = "true";
        recolor-reverse-video = "true";
        scroll-full-overlap = "0.01";
        scroll-page-aware = "true";
        scroll-step = "100";
        selection-clipboard = "clipboard";
        default-bg = "#${palette.base00}";
        default-fg = "#${palette.base01}";
        statusbar-fg = "#${palette.base04}";
        statusbar-bg = "#${palette.base02}";
        inputbar-bg = "#${palette.base00}";
        inputbar-fg = "#${palette.base07}";
        notification-bg = "#${palette.base00}";
        notification-fg = "#${palette.base07}";
        notification-error-bg = "#${palette.base00}";
        notification-error-fg = "#${palette.base08}";
        notification-warning-bg = "#${palette.base00}";
        notification-warning-fg = "#${palette.base08}";
        highlight-color = "#${palette.base0A}";
        highlight-active-color = "#${palette.base0D}";
        completion-bg = "#${palette.base01}";
        completion-fg = "#${palette.base0D}";
        completion-highlight-fg = "#${palette.base07}";
        completion-highlight-bg = "#${palette.base0D}";
        recolor-lightcolor = "#${palette.base00}";
        recolor-darkcolor = "#${palette.base06}";
      };
    };
}
