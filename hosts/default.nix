{
  homeImports,
  inputs,
  self,
  themes,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  modules = "${self}/modules/system";
  hardware = modules + "/hardware";
  profiles = "${self}/hosts/profiles";

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

        "${profiles}/hyprland"

        {
          home-manager = {
            users.rxyhn.imports = homeImports."rxyhn@hyprland";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
