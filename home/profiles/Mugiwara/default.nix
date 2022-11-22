{inputs, ...}: {
  imports = [
    ./packages.nix

    ../../wayland/hyprland
    ../../wayland/waybar
    ../../wayland/mako.nix
    ../../wayland/rofi.nix
    ../../wayland/swaylock.nix

    inputs.hyprland.homeManagerModules.default
  ];
}
