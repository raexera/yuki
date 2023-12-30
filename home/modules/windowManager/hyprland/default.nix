{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [./config];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    libnotify
    wf-recorder
    brightnessctl
    pamixer
    slurp
    grim
    hyprpicker
    swappy
    grimblast
    wl-clipboard
    cliphist
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    systemd.enable = true;
  };
}
