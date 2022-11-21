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
  server = ../modules/server;
  hw = inputs.nixos-hardware.nixosModules;
  ragenix = inputs.ragenix.nixosModules.age;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [core ragenix];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.rxyhn = ../home;
  };
in {
  # Wayland
  Mugiwara = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "Mugiwara";}
        ./Mugiwara/hardware-configuration.nix
        bootloader
        nvidia
        wayland
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
}
