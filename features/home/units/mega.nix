{ pkgs, ... }: {
  config = {
    home.packages = with pkgs; [
      megacmd
    ];
    systemd.user.services.mega-sync-server = {
      Unit = {
        Description = "MEGA sync server";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "${pkgs.megacmd}/bin/mega-cmd-server";
        Restart = "on-failure";
      };
    };
  };
}
