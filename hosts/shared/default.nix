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
    adb.enable = true;
    dconf.enable = true;
    nm-applet.enable = true;
    seahorse.enable = true;
  };

  services = {
    blueman.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    lorri.enable = true;
    udisks2.enable = true;
    printing.enable = true;
    fstrim.enable = true;
  };
}
