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
      gcalcli
      maim
      mpg123
      redshift
      taskwarrior
      timewarrior
      ;
  };
}
