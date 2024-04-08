{
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = lib.attrValues {
      inherit
        (pkgs.gnomeExtensions)
        blur-my-shell
        ;
    };
  };
}
