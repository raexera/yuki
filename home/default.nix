{
  inputs,
  lib,
  ...
}: let
  sharedModules = [
    ./modules/shell
    ./modules/programs/git.nix
  ];

  homeImports = {
    "raexera@yuki" =
      [
        ./home.nix
        ./profiles/yuki.nix
      ]
      ++ lib.concatLists [sharedModules];
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "raexera@yuki" = homeManagerConfiguration {
        inherit pkgs;
        modules = homeImports."raexera@yuki";
      };
    };
  };
}
