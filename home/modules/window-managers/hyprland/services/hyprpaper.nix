{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["${config.theme.wallpaper}"];
      wallpaper = [", ${config.theme.wallpaper}"];
    };
  };
}
