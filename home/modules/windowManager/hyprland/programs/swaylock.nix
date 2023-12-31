{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      clock = true;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;
      line-uses-inside = true;
      ignore-empty-password = true;
      show-failed-attempts = false;
      font = "Dosis";
      timestr = "%I:%M %p";
      datestr = "%d / %m / %y";
      fade-in = "0.2";
      effect-blur = "8x5";
      effect-vignette = "0.5:0.5";
      color = "00000000";
      separator-color = "00000000";
      inside-color = "#ffffff33";
      inside-clear-color = "#ffffff33";
      inside-ver-color = "#ffffff33";
      inside-wrong-color = "#ffffff33";
      ring-color = "#ffffff66";
      bs-hl-color = "#FF000066";
      key-hl-color = "#00FFFF66";
      ring-clear-color = "#00FFFF66";
      ring-ver-color = "#00FFFF66";
      ring-wrong-color = "#FF000066";
      text-color = "#00000066";
      text-clear-color = "#00000066";
      text-ver-color = "#00000066";
      text-wrong-color = "#FF000066";
    };
  };
}
