{
  inputs,
  pkgs,
  ...
}: let
  mimeTypes = [
    "application/json"
    "application/pdf"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/x-extension-xhtml"
    "application/x-extension-xht"
    "application/xhtml+xml"
    "text/html"
    "text/xml"
    "x-scheme-handler/about"
    "x-scheme-handler/ftp"
    "x-scheme-handler/http"
    "x-scheme-handler/unknown"
    "x-scheme-handler/https"
  ];
in {
  home = {
    sessionVariables.BROWSER = "firefox";

    file."firefox-gnome-theme" = {
      target = ".mozilla/firefox/rxyhn/chrome/firefox-gnome-theme";
      source = inputs.firefox-gnome-theme;
    };
  };

  xdg.mimeApps.defaultApplications = builtins.listToAttrs (map (mimeType: {
      name = mimeType;
      value = ["firefox.desktop"];
    })
    mimeTypes);

  programs.firefox = {
    enable = true;
    profiles.rxyhn = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        octotree
        refined-github
        ublock-origin
      ];

      settings = {
        "browser.tabs.loadInBackground" = true;
        "gfx.canvas.accelerated" = true;
        "gfx.webrender.enabled" = true;
        "gfx.x11-egl.force-enabled" = true;
        "layers.acceleration.force-enabled" = true;
        "media.av1.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "gnomeTheme.hideSingleTab" = true;
        "gnomeTheme.bookmarksToolbarUnderTabs" = true;
        "gnomeTheme.normalWidthTabs" = false;
        "gnomeTheme.tabsAsHeaderbar" = false;
      };

      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '';

      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';
    };
  };
}
