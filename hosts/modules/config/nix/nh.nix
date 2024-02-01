{inputs, ...}: {
  imports = [
    inputs.nh.nixosModules.default
  ];

  environment.variables.FLAKE = "/home/rxyhn/Documents/code/yuki";

  nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d";
    };
  };
}
