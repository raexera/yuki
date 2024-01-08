{
  inputs,
  withSystem,
  module_args,
  ...
}: let
  sharedModules = [
    ../.
    ../modules/shell

    module_args
    inputs.ags.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    inputs.nix-index-db.hmModules.nix-index
  ];

  homeImports = {
    "rxyhn@hiru" = [./hiru] ++ sharedModules;
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
  imports = [
    {_module.args = {inherit homeImports;};}
  ];

  flake = {
    homeConfigurations = withSystem "x86_64-linux" ({pkgs, ...}: {
      "rxyhn@hiru" = homeManagerConfiguration {
        modules = homeImports."rxyhn@hiru";
        inherit pkgs;
      };
    });
  };
}
