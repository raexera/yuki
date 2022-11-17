{
  lib,
  stdenv,
  fetchzip,
  ...
}:
stdenv.mkDerivation rec {
  pname = "cattpuccin-cursors";
  version = "0.2.7";

  src = fetchzip {
    url = "https://github.com/catppuccin/cursors/raw/21942800ad34b357a12079718a1faa88f0bccf28/cursors/Catppuccin-Mocha-Dark-Cursors.zip";
    sha256 = "I/QSk9mXrijf3LBs93XotbxIwe0xNu5xbtADIuGMDz8=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/Catppuccin-Mocha-Dark
    cp -va index.theme cursors $out/share/icons/Catppuccin-Mocha-Dark
  '';

  meta = {
    description = "Soothing pastel mouse cursors";
    homepage = "https://github.com/catppuccin/cursors";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
  };
}
