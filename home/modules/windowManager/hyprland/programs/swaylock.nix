{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      font = "Dosis";
      image = "${../assets/wallpaper.png}";
      indicator = true;
    };
  };
}
