{
  config,
  lib,
  pkgs,
  ...
}: let
  colorschemePath = "/org/gnome/desktop/interface/color-scheme";
  dconf = "${pkgs.dconf}/bin/dconf";
  dconfDark = lib.hm.dag.entryAfter ["dconfSettings"] ''
    ${dconf} write ${colorschemePath} "'prefer-dark'"
  '';
in {
  home = {
    activation = {inherit dconfDark;};

    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
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
