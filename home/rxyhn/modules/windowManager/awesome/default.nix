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

  home = {
    sessionVariables = {
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    };
  };
}
