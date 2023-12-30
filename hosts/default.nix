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
          ../modules/greetd.nix
          ../modules/desktop.nix
          {home-manager.users.rxyhn.imports = homeImports."rxyhn@hiru";}
        ]
        ++ sharedModules;
    };
  };
}
