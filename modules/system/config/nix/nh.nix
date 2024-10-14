{
  environment.variables.FLAKE = "/home/raexera/DEV/NixOS/yuki";

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d";
    };
  };
}
