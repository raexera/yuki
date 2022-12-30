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
    mkdir -p $out/share/fonts
    cp -R $src/*.otf $out/share/fonts
  '';

  meta = {description = "Apple's SFMono font nerd-font patched and ligaturized ";};
}
