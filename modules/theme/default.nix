{
  imports = [
    ./colorscheme.nix
    ./wallpaper.nix
  ];

  colorscheme = import ./schemes/catppuccin-mocha.nix;

  wallpaper = builtins.fetchurl rec {
    name = "wallpaper-${sha256}.png";
    url = "https://media.githubusercontent.com/media/rxyhn/wallpapers/main/catppuccin/cat_leaves.png";
    sha256 = "1894y61nx3p970qzxmqjvslaalbl2skj5sgzvk38xd4qmlmi9s4i";
  };
}
