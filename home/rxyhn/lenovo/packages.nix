{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      imv
      mpc_cli
      discord-canary
      feh
      fortune
      maim
      redshift
      tdesktop
      xclip
      xdotool
      xsel
      ;
  };
}
