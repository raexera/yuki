{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home.nix
    ./packages.nix

    ./modules/shell
    ./modules/xresources.nix

    (import ./modules/services/picom.nix {inherit config;})

    ./modules/desktop/gtk.nix

    ./modules/programs/firefox
    ./modules/programs/helix.nix
    ./modules/programs/kitty.nix
    ./modules/programs/mpd.nix
    ./modules/programs/obs-studio.nix
    ./modules/programs/vscode.nix
    ./modules/programs/zathura.nix
  ];
}
