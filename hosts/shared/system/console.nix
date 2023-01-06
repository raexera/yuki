{pkgs, ...}: {
  console = let
    normal = ["1c252c" "e05f65" "78dba9" "f1cf8a" "70a5eb" "c68aee" "74bee9" "dee1e6"];
    bright = ["384148" "fc7b81" "94f7c5" "ffeba6" "8cc1ff" "e2a6ff" "90daff" "fafdff"];
  in {
    colors = normal ++ bright;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };
}
