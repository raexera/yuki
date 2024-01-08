{
  self,
  inputs,
  ...
}: let
  module_args._module.args = {
    inherit inputs self;
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
