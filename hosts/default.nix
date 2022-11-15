{
  nixpkgs,
  self,
  ...
}: let
  inputs = self.inputs;
  nvidia = ../modules/nvidia;
  hmModule = inputs.home-manager.nixosModules.home-manager;
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.rxyhn = ../users/rxyhn/home.nix;
  };
in {
  NixOS = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      ./NixOS/configuration.nix
      nvidia
      hmModule
      {inherit home-manager;}
    ];
  };
}
