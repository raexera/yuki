{
  self,
  inputs,
  default,
  ...
}: let
  module_args._module.args = {
    inherit default inputs self;
  };
in {
  _module.args = {
    inherit module_args;

    sharedModules = [
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
        };
      }

      inputs.home-manager.nixosModule
      inputs.nh.nixosModules.default
      module_args
      ../settings.nix
      ./theme
    ];
  };
}
