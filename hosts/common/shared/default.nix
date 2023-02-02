# This file (and the global directory) holds config that i use on all hosts
{
  lib,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./environment
      ./pkgs
      ./programs
      ./security
      ./services
      ./system
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  programs = {
    dconf.enable = true;
    seahorse.enable = true;
  };

  services = {
    fstrim.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    printing.enable = true;
  };
}
