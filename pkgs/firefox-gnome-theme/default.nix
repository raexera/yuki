{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "firefox-gnome-theme";
  version = "dev";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = pname;
    rev = "78fb30118a58425a41ead035324c353828200112";
    sha256 = "";
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
