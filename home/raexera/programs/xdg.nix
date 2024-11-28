{config, ...}: {
  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = let
      browser = ["zen"];
      imageViewer = ["org.gnome.Loupe"];
      videoPlayer = ["io.github.celluloid_player.Celluloid"];
      audioPlayer = ["io.bassi.Amberol"];

      xdgAssociations = type: program: list:
        builtins.listToAttrs (map (e: {
            name = "${type}/${e}";
            value = program;
          })
          list);

      image = xdgAssociations "image" imageViewer ["png" "svg" "jpeg" "gif"];
      video = xdgAssociations "video" videoPlayer ["mp4" "avi" "mkv"];
      audio = xdgAssociations "audio" audioPlayer ["mp3" "flac" "wav" "aac"];

      browserTypes =
        (xdgAssociations "application" browser [
          "json"
          "pdf"
          "x-extension-htm"
          "x-extension-html"
          "x-extension-shtml"
          "x-extension-xht"
          "x-extension-xhtml"
        ])
        // (xdgAssociations "x-scheme-handler" browser [
          "about"
          "ftp"
          "http"
          "https"
          "unknown"
        ]);

      associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) ({
          "text/html" = browser;
          "text/plain" = ["codium"];
          "inode/directory" = ["thunar"];
        }
        // image
        // video
        // audio
        // browserTypes);
    in {
      enable = true;
      defaultApplications = associations;
    };

    userDirs = {
      enable = true;
      createDirectories = true;

      extraConfig = {
        XDG_DEV_DIR = "${config.home.homeDirectory}/Dev";
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
        XDG_WALLPAPERS_DIR = "${config.xdg.userDirs.pictures}/Wallpapers";
      };
    };
  };
}
