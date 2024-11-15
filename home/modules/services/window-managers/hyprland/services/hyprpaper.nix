{themes, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["${themes.wallpaper}"];
      wallpaper = [", ${themes.wallpaper}"];
    };
  };
}
