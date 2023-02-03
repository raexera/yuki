{pkgs, ...}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      gimp
      glxinfo
      nautilus-open-any-terminal
      neovide
      neovim
      sqlite
      trash-cli
      editorconfig-core-c
      fd
      gnuplot
      gnutls
      imagemagick
      sdcv
      ripgrep
      trash-cli
      zoom-us
      ;
  };
}
