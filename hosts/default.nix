{
  homeImports,
  inputs,
  self,
  themes,
  ...
}: let
  inherit (inputs.self) nixosModules;
  inherit (inputs.nixpkgs.lib) nixosSystem;
  howdy = inputs.nixpkgs-howdy;
  modules = "${self}/hosts/modules";
  hardware = modules + "/hardware";

  specialArgs = {inherit inputs self themes;};
in {
  flake.nixosConfigurations = {
    # Lenovo Yoga Slim 7i Pro X
    yuki = nixosSystem {
      inherit specialArgs;
      modules = [
        ./yuki

        "${modules}/config"
        "${modules}/programs"
        "${modules}/security"
        "${modules}/services"

        "${hardware}/bluetooth.nix"
        "${hardware}/intel.nix"
        "${hardware}/nvidia.nix"

        nixosModules.hyprland

        {
          home-manager = {
            users.rxyhn.imports = homeImports."rxyhn@hyprland";
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
