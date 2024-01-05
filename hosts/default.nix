{
  inputs,
  sharedModules,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
  in {
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
