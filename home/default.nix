{
  inputs,
  lib,
  self,
  themes,
  ...
}: let
  extraSpecialArgs = {inherit inputs self themes;};

  modules = ./modules;
  shared = modules + /shared;
  sharedModules = [
    (shared + /git.nix)
    (shared + /gpg.nix)
    (shared + /starship.nix)
    (shared + /utils.nix)
    (shared + /zsh.nix)
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
