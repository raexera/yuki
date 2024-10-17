{
  homeImports,
  inputs,
  self,
  themes,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  modules = "${self}/modules";

  hardware = modules + "/hardware";

  specialArgs = {inherit inputs self themes;};
in {
  flake.nixosConfigurations = {
    # Lenovo Yoga Slim 7i Pro X
    yuki = nixosSystem {
      inherit specialArgs;

      modules = [
        ./yuki

        "${hardware}/bluetooth.nix"
        "${hardware}/intel.nix"
        "${hardware}/nvidia.nix"

        "${modules}/core"
        "${modules}/config"
        "${modules}/programs"
        "${modules}/services"

        "${modules}/programs/hyprland.nix"

        "${modules}/virtualisation/docker.nix"

        {
          home-manager = {
            users.raexera.imports = homeImports."raexera@yuki";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
