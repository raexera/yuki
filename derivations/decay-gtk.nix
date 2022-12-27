{
  lib,
  stdenv,
  fetchzip,
  pkgs,
  ...
}:
stdenv.mkDerivation rec {
  pname = "dark-decay-gtk";
  version = "0.1.0";

  src = fetchzip {
    url = "https://github.com/decaycs/decay-gtk/releases/download/v${version}/dark-decay.zip";
    sha256 = "sha256-lT0+qJutyu9IlqzqVzSkDvUzxUbFfQMGThtVf0U7pQs=";
    stripRoot = false;
  };

  propagatedUserEnvPkgs = with pkgs; [
    gnome.gnome-themes-extra
    gtk-engine-murrine
  ];

  installPhase = ''
    mkdir -p $out/share/themes/
    cp -r Dark-decay $out/share/themes/dark-decay
  '';

  meta = {
    description = "Revamped GTK Theme for decay (Dark-decay Variant)";
    homepage = "https://github.com/decaycs/decay-gtk";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [lib.maintainers.decaycs];
  };
}
