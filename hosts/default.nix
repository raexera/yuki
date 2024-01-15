{
  homeImports,
  inputs,
  self,
  themes,
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
        nixosModules.bluetooth
        nixosModules.hyprland
        nixosModules.intel
        nixosModules.nvidia
        nixosModules.system

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
