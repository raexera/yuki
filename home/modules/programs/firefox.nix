{
  pkgs,
  inputs,
  ...
}: let
  firefox-gnome-theme = inputs.self.packages.${pkgs.system}.firefox-gnome-theme;
in {
  home.sessionVariables = {BROWSER = "firefox";};

  programs.firefox = {
    enable = true;
    profiles.rxyhn = {
      settings = {
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "gfx.x11-egl.force-enabled" = true;
        "widget.dmabuf.force-enabled" = true;
      };
      userChrome = ''
        @import "${firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "${firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
      '';
      extraConfig = builtins.readFile "${firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
    };
  };
}