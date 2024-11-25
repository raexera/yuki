{pkgs, ...}: {
  imports = [
    ./disk-configuration.nix
    ./hardware-configuration.nix

    ./programs/neovim.nix
    ./programs/nh.nix
    ./services/networking.nix
    ./services/openssh.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  services.btrfs.autoScrub.enable = true;
}
