inputs: let
  inherit (inputs) self;
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (import "${self}/home/profiles" inputs) homeImports;

  sharedModules = [
    {
      _module.args = {
        inherit inputs;
        inherit (self.lib) default;
      };
    }
    ../modules/core
    ../modules/core/bootloader
    inputs.home-manager.nixosModules.home-manager
    inputs.ragenix.nixosModules.age
    {
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        extraSpecialArgs = {inherit inputs;};
      };
    }
  ];
in {
  # Xorg
  Akagami = nixosSystem {
    modules =
      [
        {networking.hostName = "Akagami";}
        ./Akagami
        {home-manager.users.rxyhn.imports = homeImports."rxyhn@Akagami";}
      ]
      ++ sharedModules;

    system = "x86_64-linux";
  };

  # Wayland
  Mugiwara = nixosSystem {
    modules =
      [
        {networking.hostName = "Mugiwara";}
        ./Mugiwara
        {home-manager.users.rxyhn.imports = homeImports."rxyhn@Mugiwara";}
      ]
      ++ sharedModules;

    system = "x86_64-linux";
  };
}
