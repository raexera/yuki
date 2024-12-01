{
  config,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;

    font = {
      package = pkgs.geist-font;
      name = "Geist";
      size = 12;
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    theme = {
      package = pkgs.colloid-gtk-theme;
      name = "Colloid-Dark";
    };

    gtk2 = {
      extraConfig = "gtk-application-prefer-dark-theme = true";
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };

    gtk3 = {
      bookmarks = [
        "file://${config.home.homeDirectory}/Dev"
        "file://${config.home.homeDirectory}/Documents"
        "file://${config.home.homeDirectory}/Downloads"
        "file://${config.home.homeDirectory}/Music"
        "file://${config.home.homeDirectory}/Pictures"
        "file://${config.home.homeDirectory}/Videos"
      ];
      extraConfig.gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
