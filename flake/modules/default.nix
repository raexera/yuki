{self, ...}: let
  flakeModules = "${self}/modules/flake";
in {
  flake = {
    nixosModules = {};

    homeManagerModules = {};
  };
}
