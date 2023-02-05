{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
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
