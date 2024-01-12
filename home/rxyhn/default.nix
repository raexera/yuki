{
  inputs,
  withSystem,
  module_args,
  ...
}: let
  sharedModules = [
    ./home.nix

    module_args
    inputs.nix-index-db.hmModules.nix-index
  ];

  homeImports = {
    "rxyhn@hiru" = [./hiru.nix] ++ sharedModules;
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
  imports = [
    {_module.args = {inherit homeImports;};}
  ];

  flake.homeConfigurations = withSystem "x86_64-linux" ({pkgs, ...}: {
    "rxyhn@hiru" = homeManagerConfiguration {
      modules = homeImports."rxyhn@hiru";
      inherit pkgs;
    };
  });
}
