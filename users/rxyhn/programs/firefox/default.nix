{
  inputs,
  pkgs,
  ...
}: let
  nur = import inputs.nur {
    nurpkgs = pkgs;
    inherit pkgs;
  };
in {
  programs.firefox = {
    enable = true;
    extensions = with nur.repos.rycee.firefox-addons; [
      adnauseam
      enhanced-github
      enhancer-for-youtube
      refined-github
      return-youtube-dislikes
      sidebery
      stylus
      terms-of-service-didnt-read
    ];
    package = pkgs.firefox;
    profiles = {
      rxyhn = {
        id = 0;
        settings = {
          "general.smoothScroll" = true;
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
