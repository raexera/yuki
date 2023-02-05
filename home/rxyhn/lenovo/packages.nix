{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      feh
      fortune
      gcalcli
      maim
      mpg123
      redshift
      taskwarrior
      timewarrior
      ;
  };
}
