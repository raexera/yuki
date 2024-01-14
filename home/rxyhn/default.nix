{
  inputs,
  self,
  themes,
  ...
}: let
  extraSpecialArgs = {inherit inputs self themes;};

  homeImports = {
    "rxyhn@hiru" = [
      ./home.nix
      ./hiru.nix
    ];
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "rxyhn@hiru" = homeManagerConfiguration {
        modules = homeImports."rxyhn@hiru";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
