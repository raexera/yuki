{
  inputs,
  self,
  themes,
  ...
}: let
  extraSpecialArgs = {inherit inputs self themes;};

  homeImports = {
    "rxyhn@hyprland" = [
      ./home.nix
      ./profiles/hyprland.nix
    ];
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "rxyhn@hyprland" = homeManagerConfiguration {
        modules = homeImports."rxyhn@hyprland";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
