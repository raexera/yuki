{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs) lib;
    inherit (lib) nixosSystem;
    inherit (lib.attrsets) recursiveUpdate;
    inherit (lib.lists) concatLists flatten singleton;

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

    hmModules = "${self}/home";

    mkNixosSystem = {
      hostname,
      system,
      ...
    } @ args:
      nixosSystem {
        modules = concatLists [
          (singleton {
            networking.hostName = args.hostname;
            nixpkgs.hostPlatform = args.system;
          })

          (flatten (
            concatLists [
              (singleton ./${args.hostname})
              (args.modules or [])
            ]
          ))
        ];

        specialArgs = recursiveUpdate {
          inherit inputs self;
        } (args.specialArgs or {});
      };
  in {
    # Lenovo Yoga Slim 7 Pro X (14IAH7)
    yuki = mkNixosSystem {
      hostname = "yuki";
      system = "x86_64-linux";
      modules = [nixosModules sharedModules hmModules];
    };

    minimal = mkNixosSystem {
      hostname = "minimal";
      system = "x86_64-linux";
      modules = [nixosModules sharedModules];
    };
  };
}
