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
      white = "C5C8C9";
      black0 = "0D1416";
      black1 = "111719";
      black2 = "131A1C";
      black3 = "192022";
      black4 = "202729";
      gray0 = "363D3E";
      gray1 = "4A5051";
      gray2 = "5C6262";
    };

    xcolors = lib.mapAttrsRecursive (_: color: "#${color}") colors;
  };

  wallpaper = builtins.fetchurl rec {
    name = "wallpaper-${sha256}.png";
    url = "https://media.githubusercontent.com/media/rxyhn/wallpapers/main/OS/NixOS/nixos-nineish.png";
    sha256 = "0p4d88z0g487c6l4z1z27xj5k773nzhh7s2wddn976lqsnldsqs1";
  };
}
