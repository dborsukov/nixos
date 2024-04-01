{ pkgs, ... }: {
  config = {
    home.packages = with pkgs; [
      nitrogen
    ];
    systemd.user.services.nitrogen-restore = {
      Unit = {
        Description = "Restores wallpaper";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.nitrogen}/bin/nitrogen --restore";
      };
    };
  };
}
