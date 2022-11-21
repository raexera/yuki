inputs: let
  inherit (inputs) self;
  inherit (self.lib) mkHome extraSpecialArgs;

  sharedModules = [
    ../.
    ../shell
  ];

  homeImports = {
    "rxyhn@Akagami" = sharedModules ++ [./Akagami];
    "rxyhn@Mugiwara" = sharedModules ++ [./Mugiwara];
  };
in {
  inherit homeImports extraSpecialArgs;

  homeConfigurations = {
    "rxyhn@Akagami" = mkHome {modules = homeImports."rxyhn@Akagami";};
    "rxyhn@Mugiwara" = mkHome {modules = homeImports."rxyhn@Mugiwara";};
  };
}
