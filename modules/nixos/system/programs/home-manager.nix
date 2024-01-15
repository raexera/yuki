{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    sharedModules = [
      inputs.self.homeManagerModules.shell
      {home.stateVersion = lib.mkForce config.system.stateVersion;}
    ];
  };
}
