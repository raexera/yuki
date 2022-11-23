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
    url = "https://github.com/catppuccin/cursors/raw/21942800ad34b357a12079718a1faa88f0bccf28/cursors/Catppuccin-Macchiato-Dark-Cursors.zip";
    sha256 = "y1Pozu+wPRGl4ICtYuH6rl5B0b5YvbbTTEm48OollsQ=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/Catppuccin-Macchiato-Dark
    cp -va index.theme cursors $out/share/icons/Catppuccin-Macchiato-Dark
  '';

  meta = {
    description = "Soothing pastel mouse cursors";
    homepage = "https://github.com/catppuccin/cursors";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [lib.maintainers.sioodmy];
  };
}
