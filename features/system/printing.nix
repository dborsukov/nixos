{ pkgs, ... }: {
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
    ];
  };
  hardware.sane.enable = true;
  programs.system-config-printer.enable = true;
}
