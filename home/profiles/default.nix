inputs: let
  inherit (inputs) self;
  inherit (self.lib) mkHome extraSpecialArgs;

  sharedModules = [
    ../.
    ../shell
  ];

  homeImports = {
    "rxyhn@Mugiwara" = sharedModules ++ [./Mugiwara];
  };
in {
  inherit homeImports extraSpecialArgs;

  homeConfigurations = {
    "rxyhn@Mugiwara" = mkHome {modules = homeImports."rxyhn@Mugiwara";};
  };
}
