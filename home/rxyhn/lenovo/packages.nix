{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      discord-canary
      feh
      fortune
      maim
      redshift
      tdesktop
      ;
  };
}
