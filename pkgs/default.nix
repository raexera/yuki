{
  pkgs ? import <nixpkgs> {},
  inputs,
}: {
  macos-cursors = pkgs.callPackage ./macos-cursors {};
  material-symbols = pkgs.callPackage ./material-symbols {};
  firefox-gnome-theme = pkgs.callPackage ./firefox-gnome-theme {src = inputs.firefox-gnome-theme;};
  sf-mono-liga = pkgs.callPackage ./sf-mono-liga {src = inputs.sf-mono-liga;};
}
