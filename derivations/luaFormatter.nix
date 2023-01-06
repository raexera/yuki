{
  stdenv,
  pkgs,
  src,
  ...
}:
stdenv.mkDerivation {
  name = "lua-format";
  version = "dev";

  inherit src;
  nativeBuildInputs = [pkgs.cmake];
}
