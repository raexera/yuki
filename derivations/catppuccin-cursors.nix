{
  lib,
  stdenv,
  fetchzip,
  ...
}:
stdenv.mkDerivation rec {
  pname = "catppuccin-cursors";
  version = "0.2.0";

  src = fetchzip {
    url = "https://github.com/catppuccin/cursors/releases/download/v${version}/Catppuccin-Mocha-Light-Cursors.zip";
    sha256 = "sha256-evV5fBi8QYIEvd3ISGHo1NtJg4JdEH7dX1Sr3m5ODls=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/Catppuccin-Mocha-Light-Cursors
    cp -va index.theme cursors $out/share/icons/Catppuccin-Mocha-Light-Cursors
  '';

  meta = {
    description = "Soothing pastel mouse cursors";
    homepage = "https://github.com/catppuccin/cursors";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
  };
}
