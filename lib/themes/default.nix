lib: {
  colorscheme = rec {
    colors = {
      foreground = "D8DEE9";

      background = "2E3440";
      background_focus = "373E4C";
      background_dark = "242933";

      cursor = "81A1C1";
      cursor_text = "2E3440";

      accent = "89C1D1";

      normal = {
        black = "3B4252";
        red = "BF616A";
        green = "A3BE8C";
        yellow = "EBCB8B";
        blue = "81A1C1";
        magenta = "B48EAD";
        cyan = "88C0D0";
        white = "E5E9F0";
      };

      bright = {
        black = "4C566A";
        red = "BF616A";
        green = "A3BE8C";
        yellow = "D08770";
        blue = "5E81AC";
        magenta = "B48EAD";
        cyan = "8FBCBB";
        white = "ECEFF4";
      };

      dim = {
        black = "373E4D";
        red = "94545D";
        green = "809575";
        yellow = "B29E75";
        blue = "68809A";
        magenta = "8C738C";
        cyan = "6D96A5";
        white = "AEB3BB";
      };
    };

    xcolors = lib.mapAttrsRecursive (_: color: "#${color}") colors;
  };

  wallpaper = let
    url = "https://static.zerochan.net/Chifuri.full.2733257.jpg";
    sha256 = "17pjryknzb2wsj9ilq4bkk6x2ybxr2dsc8frdib0wv2qm5j15rvk";
    ext = lib.last (lib.splitString "." url);
  in
    builtins.fetchurl {
      name = "wallpaper-${sha256}.${ext}";
      inherit url sha256;
    };
}
