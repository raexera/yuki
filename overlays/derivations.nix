final: prev: {
  sf-mono-liga = prev.callPackage ../derivations/sf-mono-liga.nix {
    src = prev.sf-mono-liga-src;
    version = "999-master";
  };

  firefox-gnome-theme = prev.callPackage ../derivations/firefox-gnome-theme.nix {
    src = prev.firefox-gnome-theme-src;
    version = "999-master";
  };

  catppuccin-gtk = prev.callPackage ../derivations/catppuccin-gtk.nix {};
  catppuccin-folders = prev.callPackage ../derivations/catppuccin-folders.nix {};
  catppuccin-cursors = prev.callPackage ../derivations/catppuccin-cursors.nix {};
}
