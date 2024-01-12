{pkgs, ...}: {
  imports = [
    ./gtk.nix
    ./qt.nix
  ];

  home = {
    pointerCursor = {
      package = pkgs.catppuccin-cursors.macchiatoDark;
      name = "Catppuccin-Macchiato-Dark-Cursors";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    sessionVariables.XCURSOR_SIZE = "24";
  };
}
