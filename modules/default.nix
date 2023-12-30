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

          self.nixosModules.core
          self.nixosModules.network
          self.nixosModules.nix
        ];
      };
    }
  ];

  flake.nixosModules = {
    core = import ./core.nix;
    desktop = import ./desktop.nix;
    greetd = import ./greetd.nix;
    network = import ./network.nix;
    nix = import ./nix.nix;
  };
}
