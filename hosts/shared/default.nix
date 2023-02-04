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
      ./desktop
      ./environment
      ./programs
      ./security
      ./services
      ./system
      ./users
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
      inputs.nixpkgs-f2k.overlays.stdenvs

      (final: prev: {
        awesome = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
        vaapiIntel = prev.vaapiIntel.override {enableHybridCodec = true;};
      })
    ];

    config = {
      allowUnfree = true;
    };
  };
}
