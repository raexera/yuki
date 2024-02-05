{
  inputs,
  lib,
  ...
}: let
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
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "rxyhn@hyprland" = homeManagerConfiguration {
        modules = homeImports."rxyhn@hyprland";
      };
    };
  };
}
