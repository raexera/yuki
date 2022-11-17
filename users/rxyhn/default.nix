{
  inputs,
  pkgs,
  config,
  lib,
  self,
  ...
}: {
  home = {
    username = "rxyhn";
    homeDirectory = "/home/rxyhn";
    stateVersion = "22.05";
  };
  imports = [
    ./home.nix
    ./themes
    ./tools
    ./programs/kitty
    ./programs/shell
    ./programs/hyprland
    ./programs/waybar
    ./programs/mako
    ./programs/swaylock
    ./programs/firefox
    inputs.hyprland.homeManagerModules.default
  ];
}
