{
  stdenv,
  src,
  version,
  ...
}:
stdenv.mkDerivation {
  name = "SFMono-Nerd-Font-Ligaturized";
  inherit version;
  inherit src;
  dontConfigue = true;

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src/*.otf $out/share/fonts
  '';

  meta = {description = "Apple's SFMono font nerd-font patched and ligaturized ";};
}
