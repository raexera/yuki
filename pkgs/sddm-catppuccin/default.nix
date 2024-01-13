{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  qtgraphicaleffects,
  qtsvg,
  qtquickcontrols2,
}:
stdenvNoCC.mkDerivation {
  pname = "sddm-catppuccin";
  version = "unstable-2023-12-06";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "sddm";
    rev = "95bfcba80a3b0cb5d9a6fad422a28f11a5064991";
    hash = "sha256-Jf4xfgJEzLM7WiVsERVkj5k80Fhh1edUl6zsSBbQi6Y=";
  };

  dontConfigure = true;
  dontBuild = true;

  propagatedUserEnvPkgs = [
    qtgraphicaleffects
    qtsvg
    qtquickcontrols2
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r $src/src/catppuccin-macchiato/* $out/

    runHook postInstall
  '';

  meta = {
    description = "Soothing pastel theme for SDDM";
    homepage = "https://github.com/catppuccin/sddm";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
