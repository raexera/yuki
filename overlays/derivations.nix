final: prev: {
  macos-cursors = prev.callPackage ../derivations/macos-cursors.nix {};
  material-symbols = prev.callPackage ../derivations/material-symbols.nix {};

  firefox-gnome-theme = prev.callPackage ../derivations/firefox-gnome-theme.nix {src = prev.firefox-gnome-theme-src;};
  sf-mono-liga = prev.callPackage ../derivations/sf-mono-liga.nix {src = prev.sf-mono-liga-src;};
}
