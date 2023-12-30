{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [./config];

  home.packages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    systemd.enable = true;
  };
}
