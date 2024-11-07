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
        {networking.hostName = "yuki";}
        ./yuki/configuration.nix

        # Hardware modules
        "${hardware}/acpi_call.nix"
        "${hardware}/bluetooth.nix"
        "${hardware}/intel.nix"
        "${hardware}/nvidia.nix"
        "${hardware}/ssd.nix"

        # Core configuration
        "${modules}/core"
        "${modules}/config"
        "${modules}/system"

        # Environment
        "${modules}/environment"

        # Programs
        "${modules}/programs"
        "${modules}/programs/hyprland.nix"

        # Services
        "${modules}/services"
        "${modules}/services/greetd.nix"

        # Virtualization
        "${modules}/virtualisation"

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
