{
  flake.homeManagerModules = {
    hyprland = import ./hyprland;
    shell = import ./shell;
  };
}
