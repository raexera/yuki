{
  stdenv,
  pkgs,
  src,
  version,
  ...
}:
stdenv.mkDerivation {
  name = "lua-format";
  inherit version;
  inherit src;
  nativeBuildInputs = [pkgs.cmake];
}
