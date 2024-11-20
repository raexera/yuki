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
  ];

  mkHost = name: system:
    inputs.nixpkgs.lib.nixosSystem {
      modules =
        [
          {
            networking.hostName = name;
            nixpkgs.hostPlatform = system;
          }
          ./profiles/${name}/configuration.nix
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
