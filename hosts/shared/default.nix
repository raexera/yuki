# This file (and the global directory) holds config that i use on all hosts
{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./environment
    ./pkgs
    ./programs
    ./security
    ./services
    ./system
  ];

  programs = {
    dconf.enable = true;
    seahorse.enable = true;
  };

  services = {
    blueman.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    printing.enable = true;
  };
}
