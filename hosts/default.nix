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

    # Core modules from external inputs
    nixosModules = [
      inputs.disko.nixosModules.default
      inputs.home-manager.nixosModules.default
    ];

    # Path to the home-manager module directory
    homeModules = self + /home;

    # Common configuration shared across all systems
    sharedConfig = [
      ./config/nix
      ./config/programs
      ./config/security
      ./config/services
      ./config/shell
      ./config/system
    ];

    # Function to create a NixOS configuration for a specific hostname and system
    # Arguments:
    #  - hostname: The hostname of the system
    #  - system: The system architecture
    #  - modules (optional): Additional modules to include
    #  - specialArgs (optional): Additional special arguments passed to the system
    mkNixosSystem = {
      hostname,
      system,
      ...
    } @ args:
      nixosSystem {
        modules =
          concatLists [
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
          ]
          ++ sharedConfig;

        specialArgs = recursiveUpdate {
          inherit inputs self;
        } (args.specialArgs or {});
      };
  in {
    # Lenovo Yoga Slim 7 Pro X (14IAH7)
    yuki = mkNixosSystem {
      hostname = "yuki";
      system = "x86_64-linux";
      modules = [nixosModules homeModules];
    };

    minimal = mkNixosSystem {
      hostname = "minimal";
      system = "x86_64-linux";
      modules = [nixosModules];
    };
  };
}
