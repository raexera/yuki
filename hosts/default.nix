{
  inputs,
  self,
  themes,
  ...
}: {
  flake.nixosConfigurations = let
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

    mkNixosSystem = name: system:
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
    # Lenovo Yoga Slim 7 Pro X (14IAH7)
    yuki = mkNixosSystem "yuki" "x86_64-linux";
  };
}
