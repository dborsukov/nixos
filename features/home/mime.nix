{ ... }: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      let
        archiver = "engrampa";
        browser = "chromium";
        editor = "nvim";
        filemanager = "thunar";
        imageviewer = "nsxiv";
        mediaplayer = "mpv";
        pdfreader = "org.pwmt.zathura";
        terminal = "alacritty";
      in
      {
        "application/gzip" = "${archiver}.desktop";
        "application/x-7z-compressed" = "${archiver}.desktop";
        "application/x-apple-diskimage" = "${archiver}.desktop";
        "application/x-cpio" = "${archiver}.desktop";
        "application/x-gtar" = "${archiver}.desktop";
        "application/x-rar-compressed" = "${archiver}.desktop";
        "application/x-tar" = "${archiver}.desktop";
        "application/x-xz" = "${archiver}.desktop";
        "application/zip" = "${archiver}.desktop";
        "application/pdf" = "${pdfreader}.desktop";
        "x-scheme-handler/http" = "${browser}.desktop";
        "x-scheme-handler/https" = "${browser}.desktop";
        "x-scheme-handler/terminal" = "${terminal}.desktop";
        "audio/mpeg" = "${mediaplayer}.desktop";
        "audio/ogg" = "${mediaplayer}.desktop";
        "audio/wav" = "${mediaplayer}.desktop";
        "video/mp4" = "${mediaplayer}.desktop";
        "video/quicktime" = "${mediaplayer}.desktop";
        "video/webm" = "${mediaplayer}.desktop";
        "video/x-matroska" = "${mediaplayer}.desktop";
        "video/x-msvideo" = "${mediaplayer}.desktop";
        "image/gif" = "${mediaplayer}.desktop";
        "image/jpeg" = "${imageviewer}.desktop";
        "image/png" = "${imageviewer}.desktop";
        "image/tiff" = "${imageviewer}.desktop";
        "image/webp" = "${imageviewer}.desktop";
        "text/plain" = "${editor}.desktop";
        "text/x-markdown" = "${editor}.desktop";
        "text/x-python" = "${editor}.desktop";
        "text/x-shellscript" = "${editor}.desktop";
        "inode/directory" = "${filemanager}.desktop";
      };
  };
}
