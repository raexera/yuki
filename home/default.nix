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
    ./shell

    ./gtk

    ./wayland/hyprland
    ./wayland/waybar
    ./wayland/mako.nix
    ./wayland/rofi.nix
    ./wayland/swaylock.nix

    ./programs/kitty.nix
    ./programs/vscode.nix
    ./programs/firefox.nix
    ./programs/mpd.nix
    inputs.hyprland.homeManagerModules.default
    inputs.webcord.homeManagerModules.default
  ];
}
