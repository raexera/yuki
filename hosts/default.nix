{
  self,
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
          ../modules/nixos/hardware/audio
          ../modules/nixos/hardware/gpu/intel.nix
          ../modules/nixos/hardware/gpu/nvidia.nix
          self.nixosModules.hyprland
          {home-manager.users.rxyhn.imports = homeImports."rxyhn@hiru";}
        ]
        ++ sharedModules;
    };
  };
}
