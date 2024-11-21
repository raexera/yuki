{pkgs, ...}: {
  imports = [
    ./disk-configuration.nix
    ./hardware-configuration.nix

    ../modules/programs/bash.nix
    ../modules/programs/neovim.nix
    ../modules/programs/nh.nix
    ../modules/programs/zsh.nix
    ../modules/services/networking.nix
    ../modules/services/openssh.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  services.btrfs.autoScrub.enable = true;
}
