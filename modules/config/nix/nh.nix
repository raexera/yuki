{
  environment.variables.FLAKE = "/home/raexera/Dev/yuki";

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d";
    };
  };
}
