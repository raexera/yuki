{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    # Required to use va-api with Firefox
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      adnauseam
      enhanced-github
      enhancer-for-youtube
      octotree
      refined-github
      stylus
      ublock-origin
    ];

    profiles = {
      rxyhn = {
        id = 0;
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
          "widget.wayland-dmabuf-vaapi.enabled" = true;
          "widget.use-xdg-desktop-portal" = true;
        };

        userChrome = import ./userChrome-css.nix;
        userContent = import ./userContent-css.nix;

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("full-screen-api.ignore-widgets", true);
        '';
      };
    };
  };
}
