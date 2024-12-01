{
  inputs,
  self,
  ...
}: let
  specialArgs = {inherit inputs self;};

  sharedModules = [
    ./modules/theme
  ];
in {
  home-manager = {
    # Extra `specialArgs` passed to home-manager
    extraSpecialArgs = specialArgs;

    # Using the system configuration's `pkgs` argument in home-manager
    useGlobalPkgs = true;

    # Installation of user packages through the {option} `users.users.<name>.packages` option
    useUserPackages = true;

    # Verbose output on activation
    verbose = true;

    # Per-user home-manager configuration
    users = {
      raexera = import ./raexera;
    };

    # Extra modules added to all users
    sharedModules =
      [
        {
          # Let home-manager install and manage itself
          programs.home-manager.enable = true;

          # Avoid installing multiple variants of the home-manager manual to save space
          manual = {
            html.enable = false;
            json.enable = false;
            manpages.enable = false;
          };
        }
      ]
      ++ sharedModules;
  };
}
