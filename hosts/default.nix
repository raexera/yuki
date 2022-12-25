inputs: let
  inherit (inputs) self;
  inherit (self.lib) nixosSystem;

  sharedModules =
    [
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit inputs self;};
          users.rxyhn = ../home/rxyhn;
        };
      }
    ]
    ++ (builtins.attrValues self.nixosModules);
in {
  lenovo = nixosSystem {
    modules =
      [
        ./lenovo
        {networking.hostName = "lenovo";}
      ]
      ++ sharedModules;

    specialArgs = {inherit inputs;};
    system = "x86_64-linux";
  };
}
