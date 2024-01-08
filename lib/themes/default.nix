_lib: {
  colorscheme = {
    name = "Catppuccin Mocha";
    colors = {
      base00 = "1e1e2e";
      base01 = "181825";
      base02 = "313244";
      base03 = "45475a";
      base04 = "585b70";
      base05 = "cdd6f4";
      base06 = "f5e0dc";
      base07 = "b4befe";
      base08 = "f38ba8";
      base09 = "fab387";
      base0A = "f9e2af";
      base0B = "a6e3a1";
      base0C = "94e2d5";
      base0D = "89b4fa";
      base0E = "cba6f7";
      base0F = "f2cdcd";
    };
  };

  wallpaper = builtins.fetchurl rec {
    name = "wallpaper-${sha256}.png";
    url = "https://media.githubusercontent.com/media/rxyhn/wallpapers/main/catppuccin/exodus.png";
    sha256 = "0gzhl5b7j07jcy7qn602ji8frp1skwhanm2j2a8sp80qq8d7bhh9";
  };
}
