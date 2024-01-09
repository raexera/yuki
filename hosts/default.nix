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
          ../modules/hardware/gpu/intel.nix
          ../modules/hardware/gpu/nvidia.nix
          {home-manager.users.rxyhn.imports = homeImports."rxyhn@hiru";}
        ]
        ++ sharedModules;
    };
  };
}
