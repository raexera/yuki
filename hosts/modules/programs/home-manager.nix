{
  config,
  lib,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [
      {home.stateVersion = lib.mkForce config.system.stateVersion;}
    ];
  };
}
