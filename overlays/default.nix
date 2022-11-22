final: prev: {
  catppuccin-folders = prev.callPackage ../derivations/catppuccin-folders.nix {};
  catppuccin-gtk = prev.callPackage ../derivations/catppuccin-gtk.nix {};
  catppuccin-cursors = prev.callPackage ../derivations/catppuccin-cursors.nix {};
  rofi-emoji-wayland = prev.callPackage ../derivations/rofi-emoji-wayland.nix {};
}
