{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "macOS-Cursors";
  version = "2.0.0";

  src = fetchurl {
    url = "https://github.com/ful1e5/apple_cursor/releases/download/v${version}/macOS-Monterey.tar.gz";
    sha256 = "sha256-mEBshn+AlVLyx1mfC6LZHurCgQsDhMatlW0yF7i8EJ4=";
  };

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons
    cp -r ./macOS-* $out/share/icons
    runHook postInstall
  '';

  meta = with lib; {
    description = "Open source macOS Cursors";
    homepage = "https://github.com/ful1e5/apple_cursor";
    license = licenses.gpl3;
    platforms = platforms.unix;
  };
}
