{pkgs, ...}: {
  imports = [
    ./disk-configuration.nix
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  services.btrfs.autoScrub.enable = true;
}
