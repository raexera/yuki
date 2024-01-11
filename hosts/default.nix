{
  inputs,
  config,
  homeImports,
  sharedModules,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (config.flake) nixosModules;
    inherit (inputs.nixpkgs.lib) nixosSystem;
  in {
    # Lenovo Yoga Slim 7i Pro X
    yuki = nixosSystem {
      modules =
        [
          ./yuki
          nixosModules.system
          nixosModules.intel
          nixosModules.nvidia
          nixosModules.hyprland
          {home-manager.users.rxyhn.imports = homeImports."rxyhn@hiru";}
        ]
        ++ sharedModules;
    };
  };
}
