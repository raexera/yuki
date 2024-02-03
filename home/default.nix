{
  inputs,
  lib,
  self,
  themes,
  ...
}: let
  extraSpecialArgs = {inherit inputs self themes;};

  sharedModules = [
    ./modules/shared/git.nix
    ./modules/shared/gpg.nix
    ./modules/shared/starship.nix
    ./modules/shared/utils.nix
    ./modules/shared/zsh.nix
  ];

  homeImports = {
    "rxyhn@hyprland" =
      [
        ./home.nix
        ./profiles/hyprland.nix
      ]
      ++ lib.concatLists [sharedModules];
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
