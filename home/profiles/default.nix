{
  self,
  inputs,
  withSystem,
  module_args,
  ...
}: let
  sharedModules = [
    ../.

    module_args
    inputs.ags.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
  ];

  homeImports = {
    "rxyhn@hiru" = [./hiru] ++ sharedModules;
  };

  inherit (inputs.hm.lib) homeManagerConfiguration;
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
