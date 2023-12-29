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

          inputs.hm.nixosModule
          inputs.hyprland.nixosModules.default
          inputs.lanzaboote.nixosModules.lanzaboote
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
    lanzaboote = import ./lanzaboote.nix;
    network = import ./network.nix;
    nix = import ./nix.nix;
  };
}
