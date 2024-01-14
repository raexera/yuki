{
  self,
  inputs,
  themes,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.self) nixosModules;
    inherit (inputs.nixpkgs.lib) nixosSystem;

    specialArgs = {inherit inputs self themes;};
  in {
    # Lenovo Yoga Slim 7i Pro X
    yuki = nixosSystem {
      inherit specialArgs;
      modules = [
        ./yuki
        nixosModules.system
        nixosModules.intel
        nixosModules.nvidia
        nixosModules.hyprland

        {
          home-manager = {
            users.rxyhn.imports = homeImports."rxyhn@hiru";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
