{
  programs.firefox = {
    enable = true;

    profiles.raexera = {
      settings = {
        "browser.tabs.inTitlebar" = 0;
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.trimURLs" = true;
        "gfx.canvas.accelerated" = true;
        "gfx.webrender.all" = true;
        "gfx.webrender.enabled" = true;
        "gfx.x11-egl.force-enabled" = true;
        "media.av1.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "svg.context-properties.content.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.dmabuf.force-enabled" = true;
      };
    };
  };
}
