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
      ./console.nix
      ./environment.nix
      ./fonts.nix
      ./locale.nix
      ./networking.nix
      ./nix.nix
      ./security.nix
      ./services.nix
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
