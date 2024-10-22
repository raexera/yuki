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
    # Lenovo Yoga Slim 7 Pro X (14IAH7)
    yuki = nixosSystem {
      inherit specialArgs;

      modules = [
        # Device-specific configuration
        ./yuki/configuration.nix

        # Hardware modules
        "${hardware}/bluetooth.nix"
        "${hardware}/intel.nix"
        "${hardware}/nvidia.nix"

        # Core configuration
        "${modules}/core"
        "${modules}/config"

        # Environment
        "${modules}/environment"

        # Programs
        "${modules}/programs"
        "${modules}/programs/hyprland.nix"

        # Services
        "${modules}/services"

        # Virtualization
        "${modules}/virtualisation/docker.nix"

        # Home Manager configuration
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
