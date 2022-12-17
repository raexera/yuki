{
  lib,
  stdenv,
  fetchFromGitHub,
  papirus-icon-theme,
}:
stdenv.mkDerivation rec {
  pname = "catppuccin-folders";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "papirus-folders";
    rev = "1a367642df9cf340770bd7097fbe85b9cea65bcb";
    sha256 = "sha256-mFDfRVDA9WyriyFVzsI7iqmPopN56z54FvLkZDS2Dv8=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/Papirus
    cp -r ${papirus-icon-theme}/share/icons/Papirus $out/share/icons
    chmod -R u+rw $out
    cp -r src/* $out/share/icons/Papirus
    bash ./papirus-folders -C cat-mocha-mauve --theme $out/share/icons/Papirus -o
  '';
}
