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
    howdy = inputs.nixpkgs-howdy;

    specialArgs = {inherit inputs self themes;};
  in {
    # Lenovo Yoga Slim 7i Pro X
    yuki = nixosSystem {
      inherit specialArgs;
      modules = [
        ./yuki
        nixosModules.base
        nixosModules.bluetooth
        nixosModules.hyprland
        nixosModules.intel
        nixosModules.nvidia

        {
          home-manager = {
            users.rxyhn.imports = homeImports."rxyhn@hiru";
            extraSpecialArgs = specialArgs;
          };
        }

        {disabledModules = ["security/pam.nix"];}
        "${howdy}/nixos/modules/security/pam.nix"
        "${howdy}/nixos/modules/services/security/howdy"
        "${howdy}/nixos/modules/services/misc/linux-enable-ir-emitter.nix"
      ];
    };
  };
}
