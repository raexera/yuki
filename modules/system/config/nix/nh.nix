{inputs, ...}: {
  environment.variables.FLAKE = "/home/raexera/DEV/NixOS/yuki";

  nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d";
    };
  };
}
