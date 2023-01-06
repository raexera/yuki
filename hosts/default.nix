{
  inputs,
  outputs,
  ...
}: let
  sharedModules =
    [
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit inputs outputs;};
          users.rxyhn = ../home/rxyhn;
        };
      }
    ]
    ++ (builtins.attrValues outputs.nixosModules);
in {
  lenovo = outputs.lib.nixosSystem {
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
