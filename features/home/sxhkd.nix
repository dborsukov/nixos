{ pkgs, ... }: {
  services.sxhkd = {
    enable = true;
    keybindings = {
      # sxhkd
      "super + Escape" = "pkill -USR1 -x sxhkd";
      # launchers
      "super + Return" = "${pkgs.alacritty}/bin/alacritty";
      "super + {p,shift+p}" = "{${pkgs.rofi}/bin/rofi -show drun,${pkgs.rofi}/bin/rofi -show run}";
      # bspwm
      "super + alt + r" = "bspc wm -r";
      "super + shift + {q,ctrl+q}" = "bspc node -{c,k}";
      "super + {t,shift+f,f}" = "bspc node -t {tiled,floating,\\~fullscreen}";
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      "super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";
    };
  };
}
