{
  imports = [
    ./colorscheme.nix
    ./wallpaper.nix
  ];

  colorscheme = {
    colors = {
      foreground = "d3c6aa";
      background = "232a2e";
      color0 = "7a8478";
      color8 = "7a8478";
      color1 = "e67e80";
      color9 = "e67e80";
      color2 = "a7c080";
      color10 = "a7c080";
      color3 = "dbbc7f";
      color11 = "dbbc7f";
      color4 = "7fbbb3";
      color12 = "7fbbb3";
      color5 = "d699b6";
      color13 = "d699b6";
      color6 = "83c092";
      color14 = "83c092";
      color7 = "d3c6aa";
      color15 = "d3c6aa";
    };
  };

  wallpaper = builtins.fetchurl rec {
    name = "wallpaper-${sha256}.png";
    url = "https://media.githubusercontent.com/media/rxyhn/wallpapers/main/everforest/fuji-mountain.png";
    sha256 = "13yiv5z8ka2gh0d5w8nfxj9mwhaks4cm9p8z74iicnnjyai91rv0";
  };
}
