{
  flake = {
    nixosModules = {};

    homeManagerModules = {
      swaync = import ./home-manager/swaync.nix;
    };
  };
}
