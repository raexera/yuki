{
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./base
      ./environment
      ./networking
      ./pkgs
      ./programs
      ./security
      ./services
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.default
      inputs.nixpkgs-f2k.overlays.stdenvs
    ];

    config = {
      allowUnfree = true;
    };
  };
}
