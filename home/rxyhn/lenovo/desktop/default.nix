{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "phocus";
      package = inputs.nixpkgs-f2k.packages.${pkgs.system}.phocus.override {
        colors = {
          base00 = "${colors.base00}";
          base01 = "${colors.base01}";
          base02 = "${colors.base02}";
          base03 = "${colors.base03}";
          base04 = "${colors.base04}";
          base05 = "${colors.base05}";
          base06 = "${colors.base06}";
          base07 = "${colors.base07}";
          base08 = "${colors.base08}";
          base09 = "${colors.base09}";
          base0A = "${colors.base0A}";
          base0B = "${colors.base0B}";
          base0C = "${colors.base0C}";
          base0D = "${colors.base0D}";
          base0E = "${colors.base0E}";
          base0F = "${colors.base0F}";
        };

        primary = "${colors.base0C}";
        secondary = "${colors.base0B}";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "sans-serif";
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
      name = "adwaita-dark";
    };
  };

  home.pointerCursor = {
    name = "macOS-Monterey";
    package = pkgs.macos-cursors;
    size = 48;
    gtk.enable = true;
  };

  home.sessionVariables = {
    GTK_THEME = "phocus";
    XCURSOR_SIZE = "48";
  };
}
