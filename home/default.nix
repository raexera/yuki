{
  inputs,
  lib,
  ...
}: let
  sharedModules = [
    ./modules/programs/ssh.nix
    ./modules/shared/git.nix
    ./modules/shared/gpg.nix
    ./modules/shared/starship.nix
    ./modules/shared/utils.nix
    ./modules/shared/zsh.nix
    ./modules/services/gnome-keyring.nix
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
        inherit pkgs;
        modules = homeImports."rxyhn@hyprland";
      };
    };
  };
}
