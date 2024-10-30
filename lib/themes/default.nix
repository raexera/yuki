lib: {
  colorscheme = rec {
    colors = {
      # Catppuccin v0.1.3
      rosewater = "F5E0DC";
      flamingo = "F2CDCD";
      pink = "F5C2E7";
      mauve = "DDB6F2";
      red = "F28FAD";
      maroon = "E8A2AF";
      peach = "F8BD96";
      yellow = "FAE3B0";
      green = "ABE9B3";
      teal = "B5E8E0";
      blue = "96CDFB";
      sky = "89DCEB";
      lavender = "C9CBFF";
      black0 = "0D1416";
      black1 = "111719";
      black2 = "131A1C";
      black3 = "192022";
      black4 = "202729";
      gray0 = "363D3E";
      gray1 = "4A5051";
      gray2 = "5C6262";
      white = "C5C8C9";
    };

    xcolors = lib.mapAttrsRecursive (_: color: "#${color}") colors;
  };

  wallpaper = let
    url = "https://static.zerochan.net/Chifuri.full.2897158.jpg";
    sha256 = "1dhps7zzlpjdmbyl0b3a3650jpc82in6gbzzxhzrlzhbqjg9d44z";
    ext = lib.last (lib.splitString "." url);
  in
    builtins.fetchurl {
      name = "wallpaper-${sha256}.${ext}";
      inherit url sha256;
    };
}
