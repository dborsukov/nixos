{ pkgs, ... }: {
  programs.mpv = {
    enable = true;
    config = {
      osc = "no";
      border = "no";
      osd-bar = "no";
      sub-font-size = 16;
      save-position-on-quit = "yes";
      video-sync = "display-resample";
      demuxer-mkv-subtitle-preroll = "yes";
      alang = "enGB,en-GB,en,eng,enUS,en-US";
      slang = "enGB,en-GB,en,eng,enUS,en-US,unknown";
    };
    profiles = {
      "extension.gif" = {
        cache = "no";
        no-pause = "";
        loop-file = "yes";
      };
      "extension.webm" = {
        no-pause = "";
        loop-file = "yes";
      };
    };
    bindings = {
      tab = "script-binding uosc/toggle-ui";
    };
    scripts = with pkgs.mpvScripts; [
      autoload
      thumbfast
      uosc
    ];
  };
}
