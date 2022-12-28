final: prev: {
  material-symbols = prev.callPackage ../derivations/material-symbols.nix {};
  decay-gtk = prev.callPackage ../derivations/decay-gtk.nix {};
  macos-cursors = prev.callPackage ../derivations/macos-cursors.nix {};

  sf-mono-liga = prev.callPackage ../derivations/sf-mono-liga.nix {
    src = prev.sf-mono-liga-src;
    version = "999-master";
  };

  firefox-gnome-theme = prev.callPackage ../derivations/firefox-gnome-theme.nix {
    src = prev.firefox-gnome-theme-src;
    version = "999-master";
  };

  luaFormatter = prev.callPackage ../derivations/luaFormatter.nix {
    src = prev.luaFormatter-src;
    version = "999-master";
  };
}
