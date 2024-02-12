{
  pkgs,
  themes,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      image = themes.wallpaper;
      grace = 5;
      clock = true;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      line-uses-inside = true;
      line-uses-ring = false;

      font = "Inter";
      timestr = "%I:%M %p";
      datestr = "%d / %m / %y";
      fade-in = "0.1";
      effect-blur = "10x5";

      ring-color = "#00000080";
      line-color = "#00000080";
      inside-color = "#00000080";
      inside-ver-color = "#00000080";
      inside-wrong-color = "#00000080";
      inside-clear-color = "#00000080";
      line-clear-color = "#00000080";
      line-wrong-color = "#00000080";
      text-color = "#ffffff";
      text-caps-lock-color = "#ffffff";
      text-ver-color = "#ffffff";
      text-clear-color = "#ffffff";
      text-wrong-color = "#ff443a";
      ring-wrong-color = "#ff443a";
      key-hl-color = "#0a84ff";
      line-ver-color = "#0a84ff";
      ring-ver-color = "#0a84ff";
      ring-clear-color = "#0a84ff";
      bs-hl-color = "#0a84ff";
      separator-color = "#0a84ff";
    };
  };
}
