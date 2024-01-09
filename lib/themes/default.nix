_lib: {
  colorscheme = {
    colors = {
      rosewater = "F5E0DC"; # Rosewater
      flamingo = "F2CDCD"; # Flamingo
      mauve = "DDB6F2"; # Mauve
      pink = "F5C2E7"; # Pink
      red = "F28FAD"; # Red
      maroon = "E8A2AF"; # Maroon
      peach = "F8BD96"; # Peach
      yellow = "FAE3B0"; # Yellow
      green = "ABE9B3"; # Green
      blue = "96CDFB"; # Blue
      sky = "89DCEB"; # Sky
      teal = "B5E8E0"; # Teal
      lavender = "C9CBFF"; # Lavender
      white = "c5c8c9";
      black0 = "0d1416";
      black1 = "111719";
      black2 = "131a1c";
      black3 = "192022";
      black4 = "202729";
      gray0 = "363D3E";
      gray1 = "4A5051";
      gray2 = "5C6262";
    };
  };

  wallpaper = builtins.fetchurl rec {
    name = "wallpaper-${sha256}.png";
    url = "https://media.githubusercontent.com/media/rxyhn/wallpapers/main/OS/NixOS/nixos-nineish.png";
    sha256 = "0p4d88z0g487c6l4z1z27xj5k773nzhh7s2wddn976lqsnldsqs1";
  };
}
