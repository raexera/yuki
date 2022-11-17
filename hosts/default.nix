{
  nixpkgs,
  self,
  ...
}: let
  inputs = self.inputs;
  bootloader = ../modules/core/bootloader;
  core = ../modules/core;
  nvidia = ../modules/nvidia;
  wayland = ../modules/wayland;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.rxyhn = ../users/rxyhn;
  };
in {
  akagami = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      {networking.hostName = "akagami";}
      ./akagami/configuration.nix
      ./akagami/hardware-configuration.nix
      bootloader
      core
      nvidia
      wayland
      hmModule
      {inherit home-manager;}
    ];
  };
}
