{
  imports = [
    ./colorscheme.nix
    ./wallpaper.nix
  ];

  colorscheme = import ./colorschemes/yoru.nix;

  wallpaper = builtins.fetchurl rec {
    name = "wallpaper-${sha256}.png";
    url = "https://media.githubusercontent.com/media/rxyhn/wallpapers/main/anime/nord.png";
    sha256 = "0jbnr6qhqdwki0rzbq4x41car77mpdfpb0p2v7yfwl15m4f1ibkm";
  };
}
