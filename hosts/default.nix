{
  homeImports,
  inputs,
  self,
  themes,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  specialArgs = {inherit inputs self themes;};
in {
  flake.nixosConfigurations = {
    # Lenovo Yoga Slim 7 Pro X (14IAH7)
    yuki = nixosSystem {
      inherit specialArgs;

      modules = [
        # nixosModules
        inputs.disko.nixosModules.default
        inputs.auto-cpufreq.nixosModules.default

        # Device-specific configuration
        {networking.hostName = "yuki";}
        ./yuki/configuration.nix

        # Core configuration
        ./modules/config
        ./modules/security
        ./modules/system
        ./modules/system/boot.nix

        # Hardware modules
        ./modules/hardware/bluetooth.nix
        ./modules/hardware/intel.nix
        ./modules/hardware/nvidia.nix
        ./modules/hardware/ssd.nix

        # Environment
        ./modules/environment

        # Programs
        ./modules/programs
        ./modules/programs/hyprland.nix

        # Services
        ./modules/services
        ./modules/services/greetd.nix

        # Virtualization
        ./modules/virtualisation

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
