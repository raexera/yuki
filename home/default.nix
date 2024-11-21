{
  inputs,
  self,
  themes,
  ...
}: let
  specialArgs = {inherit inputs self themes;};
in {
  home-manager = {
    # Extra `specialArgs` passed to Home Manager
    extraSpecialArgs = specialArgs;

    # Using the system configuration's `pkgs` argument in Home Manager
    useGlobalPkgs = true;

    # Installation of user packages through the {option} `users.users.<name>.packages` option
    useUserPackages = true;

    # Per-user Home Manager configurations
    users = {
      raexera = import ./raexera;
    };

    # Extra modules added to all users
    sharedModules = [
      {
        # Avoid installing multiple variants of the home manager manual to save space
        manual = {
          html.enable = false;
          json.enable = false;
          manpages.enable = false;
        };

        # Let Home Manager install and manage itself
        programs.home-manager.enable = true;
      }
    ];
  };
}
