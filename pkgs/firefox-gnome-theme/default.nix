{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "108.1";

  src = fetchFromGitHub {
    repo = pname;
    owner = "rafaelmardojai";
    rev = "v${version}";
    sha256 = "sha256-1nGpcIG2OLwVi9Y93rJGZXCjJM9mSHHta+6WeqEjZng=";
  };

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/firefox-gnome-theme
    cp -r $src/* $out/share/firefox-gnome-theme
  '';

  meta = with lib; {
    description = "A GNOME theme for Firefox";
    homepage = "https://github.com/rafaelmardojai/firefox-gnome-theme";
    license = licenses.unlicense;
  };
}
