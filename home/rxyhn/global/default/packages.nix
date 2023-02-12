{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
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
      xsel
      zoom-us
      ;

    inherit
      (pkgs.gnome)
      dconf-editor
      eog
      gnome-disk-utility
      nautilus
      sushi
      ;
  };
}
