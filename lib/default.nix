inputs: let
  inherit (inputs.nixpkgs) lib;

  colors = import ./colors.nix lib;
  home = import ./home.nix inputs;
in
  lib // colors // home
