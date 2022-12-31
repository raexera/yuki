{
  stdenv,
  src,
  ...
}:
stdenv.mkDerivation {
  name = "SFMono-Nerd-Font-Ligaturized";
  version = "dev";

  inherit src;
  dontConfigue = true;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp -R $src/*.otf $out/share/fonts/opentype/
  '';

  meta = {description = "Apple's SFMono font nerd-font patched and ligaturized ";};
}
