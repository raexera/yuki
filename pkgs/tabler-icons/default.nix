{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  pname = "tabler-icons";
  version = "2.44.0";

  meta = with lib; {
    description = "Tabler Icons";
    homepage = "https://tabler.io/icons";
    license = licenses.mit;
    platforms = platforms.all;
  };

  src = fetchFromGitHub {
    owner = "tabler";
    repo = "tabler-icons";
    rev = "v${version}";
    sha256 = "sha256-jfVCmpiLpIHGWFKi5Nr2NslPUJSjF9SLpryp2os3+t4=";
    sparseCheckout = ["packages/icons-webfont/fonts"];
  };

  installPhase = ''
    runHook preInstall

    install -m444 -Dt $out/share/fonts/TTF packages/icons-webfont/fonts/*.ttf
    install -m444 -Dt $out/share/fonts/woff packages/icons-webfont/fonts/*.woff
    install -m444 -Dt $out/share/fonts/woff2 packages/icons-webfont/fonts/*.woff2


    runHook postInstall
  '';
}
