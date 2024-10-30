lib: {
  colorscheme = rec {
    colors = {
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
      sky = "89DCEB";
      blue = "96CDFB";
      lavender = "C9CBFF";
      white = "C5C8C9"; # text
      gray2 = "5C6262";
      gray1 = "4A5051"; # surface2
      gray0 = "363D3E"; # surface1
      black4 = "202729";
      black3 = "192022"; # surface0
      black2 = "131A1C"; # base
      black1 = "111719"; # mantle
      black0 = "0D1416"; # crust
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
