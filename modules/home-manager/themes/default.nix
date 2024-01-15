{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./gtk.nix
    ./qt.nix
  ];

  home = {
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    sessionVariables = {
      GTK_THEME = config.gtk.theme.name;
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = config.home.pointerCursor.name;
    };
  };
}
