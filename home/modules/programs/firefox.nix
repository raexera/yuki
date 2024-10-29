{
  programs.firefox = {
    enable = true;

    profiles.raexera = {
      settings = {
        "gfx.canvas.accelerated" = true;
        "gfx.webrender.all" = true;
        "gfx.webrender.enabled" = true;
        "gfx.x11-egl.force-enabled" = true;
        "media.av1.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "widget.dmabuf.force-enabled" = true;
      };
    };
  };
}
