{
  inputs,
  homeImports,
  sharedModules,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
  in {
    # Lenovo Yoga Slim 7i Pro X
    yuki = nixosSystem {
      modules =
        [
          ./yuki
          {home-manager.users.rxyhn.imports = homeImports."rxyhn@hiru";}
        ]
        ++ sharedModules;
    };
  };
}
