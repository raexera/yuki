{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  programs.firefox = {
    enable = true;
    profiles = {
      rxyhn = {
        id = 0;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          adnauseam
          enhanced-github
          enhancer-for-youtube
          octotree
          refined-github
          stylus
          ublock-origin
        ];

        settings = {
          "general.smoothScroll" = true;
          "gfx.canvas.accelerated" = true;
          "gfx.webrender.enabled" = true;
          "gfx.x11-egl.force-enabled" = true;
          "layers.acceleration.force-enabled" = true;
          "media.av1.enabled" = false;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.hardware-video-decoding.force-enabled" = true;
          "media.rdd-ffmpeg.enabled" = true;
          "widget.dmabuf.force-enabled" = true;
          "widget.use-xdg-desktop-portal" = true;
          "extensions.pocket.enabled" = false;
          "extensions.pocket.onSaveRecs" = false;
        };

        userChrome = ''
          @import "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
        '';

        userContent = ''
          @import "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
        '';

        extraConfig = builtins.readFile "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
      };
    };
  };
}
