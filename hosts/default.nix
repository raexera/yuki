{
  homeImports,
  inputs,
  self,
  themes,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  modules = "${self}/modules";

  system = modules + "/system";
  hardware = system + "/hardware";
  profiles = modules + "/profiles";

  specialArgs = {inherit inputs self themes;};
in {
  flake.nixosConfigurations = {
    # Lenovo Yoga Slim 7i Pro X
    yuki = nixosSystem {
      inherit specialArgs;

      modules = [
        ./yuki

        "${system}/config"
        "${system}/programs"
        "${system}/security"
        "${system}/services"
        "${system}/virtualisation/docker.nix"

        "${hardware}/bluetooth.nix"
        "${hardware}/intel.nix"
        "${hardware}/nvidia.nix"

        "${profiles}/hyprland"

        {
          home-manager = {
            users.raexera.imports = homeImports."raexera@hyprland";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
