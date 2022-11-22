final: prev: {
  catppuccin-folders = prev.callPackage ./catppuccin-folders.nix {};
  catppuccin-gtk = prev.callPackage ./catppuccin-gtk.nix {};
  catppuccin-cursors = prev.callPackage ./catppuccin-cursors.nix {};
  rofi-emoji-wayland = prev.callPackage ./rofi-emoji-wayland.nix {};
}
