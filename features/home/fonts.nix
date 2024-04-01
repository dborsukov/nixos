{ pkgs, ... }: {
  fontProfiles = {
    enable = true;
    sans = {
      family = "Ubuntu";
      package = pkgs.ubuntu_font_family;
    };
    serif = {
      family = "Ubuntu";
      package = pkgs.ubuntu_font_family;
    };
    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    };
  };
}
