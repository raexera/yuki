lib: {
  colorscheme = rec {
    colors = {
      rosewater = "f4dbd6";
      flamingo = "f0c6c6";
      pink = "f5bde6";
      mauve = "c6a0f6";
      red = "ed8796";
      maroon = "ee99a0";
      peach = "f5a97f";
      yellow = "eed49f";
      green = "a6da95";
      teal = "8bd5ca";
      sky = "91d7e3";
      sapphire = "7dc4e4";
      blue = "8aadf4";
      lavender = "b7bdf8";
      white = "c5c8c9";
      black0 = "0d1416";
      black1 = "111719";
      black2 = "131a1c";
      black3 = "192022";
      black4 = "202729";
      gray0 = "363d3e";
      gray1 = "4a5051";
      gray2 = "5c6262";
    };

    xcolors = lib.mapAttrsRecursive (_: color: "#${color}") colors;
  };

  wallpaper = builtins.fetchurl rec {
    name = "wallpaper-${sha256}.png";
    url = "https://media.githubusercontent.com/media/rxyhn/wallpapers/main/OS/NixOS/nixos-nineish.png";
    sha256 = "0p4d88z0g487c6l4z1z27xj5k773nzhh7s2wddn976lqsnldsqs1";
  };
}
