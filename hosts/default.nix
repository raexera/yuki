{
  nixpkgs,
  self,
  ...
}: let
  inputs = self.inputs;
  bootloader = ../modules/core/bootloader;

  sharedModules = [
    ../modules/core
    inputs.home-manager.nixosModules.home-manager
    inputs.ragenix.nixosModules.age
    {
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        extraSpecialArgs = {
          inherit inputs;
          inherit self;
        };
        users.rxyhn = ../home;
      };
    }
  ];
in {
  # Wayland
  Mugiwara = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules =
      [
        {networking.hostName = "Mugiwara";}
        ./Mugiwara
        bootloader
      ]
      ++ sharedModules;

    system = "x86_64-linux";
  };
}
