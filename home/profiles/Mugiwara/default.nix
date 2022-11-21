{inputs, ...}: {
  imports = [
    ./packages.nix

    ../../gtk

    ../../wayland/hyprland
    ../../wayland/waybar
    ../../wayland/mako.nix
    ../../wayland/rofi.nix
    ../../wayland/swaylock.nix

    ../../programs/kitty.nix
    ../../programs/vscode.nix
    ../../programs/firefox.nix
    ../../programs/mpd.nix
    inputs.hyprland.homeManagerModules.default
    inputs.webcord.homeManagerModules.default
  ];
}
