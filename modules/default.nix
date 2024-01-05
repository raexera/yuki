{
  self,
  inputs,
  default,
  lib,
  ...
}: let
  module_args._module.args = {
    inherit default inputs self;
  };
in {
  imports = [
    {
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
        ];
      };
    }
  ];
}
