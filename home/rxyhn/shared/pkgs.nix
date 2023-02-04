{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      bc
      cached-nix-shell
      editorconfig-core-c
      gimp
      glxinfo
      grex
      hddtemp
      hyperfine
      imv
      mpc_cli
      nautilus-open-any-terminal
      sdcv
      sqlite
      trash-cli
      wirelesstools
      xclip
      zoom-us
      ;

    inherit
      (pkgs.gnome)
      eog
      gnome-disk-utility
      nautilus
      sushi
      ;
  };
}
