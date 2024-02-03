{self, ...}: let
  flakeModules = "${self}/modules/flake";
in {
  flake = {
    nixosModules = {};

    homeManagerModules = {
      swaync = "${flakeModules}/home-manager/swaync";
    };
  };
}
