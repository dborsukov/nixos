{ config, ... }: {
  xsession = {
    enable = true;
    windowManager.bspwm = {
      enable = true;
      extraConfigEarly = "bspc monitor -d 1 2 3 4 5 6 7 8 9 10";
      settings =
        let
          palette = config.colorscheme.palette;
        in
        {
          window_gap = 0;
          border_width = 1;
          split_ratio = 0.5;
          single_monocle = true;
          borderless_monocle = true;
          active_border_color = "#${palette.base03}";
          focused_border_color = "#${palette.base08}";
          normal_border_color = "#${palette.base01}";
          presel_feedback_color = "#${palette.base08}";
        };
    };
  };
}
