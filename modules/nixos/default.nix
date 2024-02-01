{
  flake.nixosModules = {
    greetd = import ./services/display-managers/greetd.nix;
    hyprland = import ./services/wayland/window-managers/hyprland.nix;
  };
}
