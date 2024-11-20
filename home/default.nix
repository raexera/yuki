{
  inputs,
  self,
  themes,
  ...
}: let
  specialArgs = {inherit inputs self themes;};
in {
  home-manager = {
    # Installation of user packages through the {option} `users.users.<name>.packages` option.
    useUserPackages = true;

    # Using the system configuration's `pkgs` argument in Home Manager.
    useGlobalPkgs = true;

    # Verbose output on activation.
    verbose = true;

    # Extra `specialArgs` passed to Home Manager.
    extraSpecialArgs = specialArgs;

    # Per-user Home Manager configurations.
    users.raexera = import ./raexera;

    # Extra modules added to all users.
    sharedModules = [
      {
        # Allow HM to manage itself when in standalone mode.
        programs.home-manager.enable = true;

        # Avoid installing multiple variants of the home manager manual to save space.
        manual = {
          html.enable = false;
          json.enable = false;
          manpages.enable = false;
        };
      }
    ];
  };
}
