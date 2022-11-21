{
  inputs,
  pkgs,
  config,
  lib,
  self,
  ...
}:
# glue all configs together
{
  config.home.stateVersion = "22.05";
  imports = [
    ./packages.nix

    ./gtk
    ./mako
    ./rofi
    ./shell
    ./swaylock
    ./tools
    ./waybar
    ./hyprland
    ./mpd

    ./programs/kitty.nix
    ./programs/vscode.nix
    ./programs/firefox.nix
    inputs.hyprland.homeManagerModules.default
    inputs.webcord.homeManagerModules.default
  ];
}
