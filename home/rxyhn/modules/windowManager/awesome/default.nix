{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./components/gtk.nix
    ./components/picom.nix
    ./components/xresources.nix
  ];
}
