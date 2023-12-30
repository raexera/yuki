{
  config,
  pkgs,
  inputs,
  ...
}: let
  firefox-gnome-theme = inputs.self.packages.${pkgs.system}.firefox-gnome-theme;
in {
  programs.firefox = {
    enable = true;
    profiles = {
      rxyhn = {
        userChrome = ''
          @import "${firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
        '';

        userContent = ''
          @import "${firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
        '';

        extraConfig = builtins.readFile "${firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
      };
    };
  };
}
