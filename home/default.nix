{
  inputs,
  self,
  ...
}: let
  specialArgs = {inherit inputs self;};
in {
  home-manager = {
    # Extra `specialArgs` passed to Home Manager
    extraSpecialArgs = specialArgs;

    # Using the system configuration's `pkgs` argument in Home Manager
    useGlobalPkgs = true;

    # Installation of user packages through the {option} `users.users.<name>.packages` option
    useUserPackages = true;

    # Verbose output on activation
    verbose = true;

    # Home Manager configurations
    users.raexera = import ./raexera;

    # Extra modules added to all users
    sharedModules = [
      {
        # Let Home Manager install and manage itself
        programs.home-manager.enable = true;

        # Avoid installing multiple variants of the Home Manager manual to save space
        manual = {
          html.enable = false;
          json.enable = false;
          manpages.enable = false;
        };
      }
    ];
  };
}
