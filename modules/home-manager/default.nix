{
  flake.homeModules = {
    hyprland = import ./hyprland;
    shell = import ./shell;
  };
}
