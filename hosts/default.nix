{
  homeImports,
  inputs,
  self,
  themes,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  specialArgs = {inherit inputs self themes;};

  nixosModules = [
    inputs.disko.nixosModules.default
    inputs.auto-cpufreq.nixosModules.default
  ];
in {
  flake.nixosConfigurations = {
    # Lenovo Yoga Slim 7 Pro X (14IAH7)
    yuki = nixosSystem {
      inherit specialArgs;

      modules =
        [
          {networking.hostName = "yuki";}
          ./profiles/yuki/configuration.nix

          {
            home-manager = {
              users.raexera.imports = homeImports."raexera@yuki";
              extraSpecialArgs = specialArgs;
            };
          }
        ]
        ++ nixosModules;
    };
  };
}
