{inputs, ...}: {
  imports = [
    ./hyprland
    inputs.hyprland.homeManagerModules.default
  ];
}
