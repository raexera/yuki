{
  inputs,
  pkgs,
  ...
}: {
  home = {
    pointerCursor = {
      name = "macOS-Monterey";
      package = pkgs.macos-cursors;
      size = 48;
      gtk.enable = true;
      x11.enable = true;
    };

    sessionVariables = {
      GTK_THEME = "WhiteSur-dark";
      XCURSOR_SIZE = "48";
    };
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    font = {
      name = "sans-serif";
      size = 13;
    };

    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';

    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-decoration-layout = "menu:";
    };

    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };

    theme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-gtk-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };
}
