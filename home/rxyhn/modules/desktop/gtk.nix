{
  inputs,
  pkgs,
  config,
  ...
}: let
  inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
in {
  gtk = {
    enable = true;
    theme = {
      name = "${config.colorscheme.slug}";
      package = gtkThemeFromScheme {
        scheme = config.colorscheme;
      };
    };

    iconTheme = {
      name = "${
        if config.colorscheme.kind == "light"
        then "Papirus-Light"
        else "Papirus-Dark"
      }";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "Inter";
      size = 13;
    };

    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-decoration-layout = "menu:";
    };

    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "${
        if config.colorscheme.kind == "light"
        then "adwaita"
        else "adwaita-dark"
      }";
    };
  };

  home.pointerCursor = {
    name = "${
      if config.colorscheme.kind == "light"
      then "capitaine-cursors"
      else "capitaine-cursors-white"
    }";
    package = pkgs.capitaine-cursors;
    size = 24;
    gtk.enable = true;
  };
}
