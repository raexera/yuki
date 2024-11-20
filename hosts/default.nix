{
  inputs,
  lib,
  self,
  themes,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (lib.lists) concatLists flatten singleton;

    nixosModules = [
      inputs.disko.nixosModules.default
    ];

    hmModules = [
      inputs.home-manager.nixosModules.default
      ../home
    ];

    sharedModules = [
      ./modules/config
      ./modules/environment
      ./modules/security
      ./modules/system
    ];

    mkNixosSystem = {
      hostname,
      system,
      extraModules ? [],
      ...
    } @ args:
      inputs.nixpkgs.lib.nixosSystem {
        modules = concatLists [
          (singleton {
            networking.hostName = args.hostname;
            nixpkgs.hostPlatform = args.system;
          })

          (flatten (
            concatLists [
              (singleton ./${args.hostname})
              args.extraModules
            ]
          ))
        ];

        specialArgs = {inherit inputs self themes;};
      };
  in {
    # Lenovo Yoga Slim 7 Pro X (14IAH7)
    yuki = mkNixosSystem {
      hostname = "yuki";
      system = "x86_64-linux";
      extraModules = [nixosModules hmModules sharedModules];
    };
  };
}
