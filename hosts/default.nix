{
  self,
  inputs,
  themes,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.self) nixosModules homeModules;
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
        inputs.home-manager.nixosModule
        inputs.hyprland.nixosModules.default
        inputs.nh.nixosModules.default

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = [homeModules.shell];
            users.rxyhn.imports = homeImports."rxyhn@hiru";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
