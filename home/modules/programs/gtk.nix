{
  pkgs,
  config,
  ...
}: {
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "Dosis";
      package = pkgs.dosis;
      size = 11;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };
}
