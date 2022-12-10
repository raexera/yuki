{
  config,
  pkgs,
  package,
  ...
}: {
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

    inherit package;

    profiles = {
      rxyhn = {
        id = 0;
        settings = {
          "general.smoothScroll" = true;
        };
        userChrome = import ./userChrome-css.nix {
          inherit (config) colorscheme;
        };
        userContent = import ./userContent-css.nix {
          inherit (config) colorscheme;
        };
        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("full-screen-api.ignore-widgets", true);
          user_pref("media.ffmpeg.vaapi.enabled", true);
          user_pref("media.rdd-vpx.enabled", true);
        '';
      };
    };
  };
}
