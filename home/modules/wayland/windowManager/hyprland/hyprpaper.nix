{
  inputs,
  pkgs,
  themes,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.system}.default;

    settings = {
      preload = ["${themes.wallpaper}"];
      wallpaper = [", ${themes.wallpaper}"];
    };
  };
}
