{
  inputs,
  self,
  themes,
  ...
}: let
  nixosModules = [
    inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.default
  ];

  sharedModules = [
    ./modules/config
    ./modules/environment
    ./modules/security
    ./modules/system
    ../home
  ];

  mkHost = name: system:
    inputs.nixpkgs.lib.nixosSystem {
      modules =
        [
          {
            networking.hostName = name;
            nixpkgs.hostPlatform = system;
          }
          ./${name}
        ]
        ++ nixosModules
        ++ sharedModules;

      specialArgs = {inherit inputs self themes;};
    };
in {
  flake.nixosConfigurations = {
    # Lenovo Yoga Slim 7 Pro X (14IAH7)
    yuki = mkHost "yuki" "x86_64-linux";
  };
}
