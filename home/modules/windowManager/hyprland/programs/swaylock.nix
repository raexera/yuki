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
      grace = 0;
      grace-no-mouse = true;
      grace-no-touch = true;
      line-uses-inside = false;
      line-uses-ring = false;
      ignore-empty-password = true;
      show-failed-attempts = false;
      font = "Dosis";
      timestr = "%I:%M %p";
      datestr = "%d / %m / %y";
      fade-in = "0.1";
      effect-blur = "10x5";
      color = "00000000";
      separator-color = "00000000";
      line-color = "#00000033";
      inside-color = "#00000033";
      inside-ver-color = "#00000033";
      inside-wrong-color = "#00000033";
      inside-clear-color = "#00000033";
      line-clear-color = "#00000033";
      line-wrong-color = "#00000033";
      ring-color = "#00000066";
      text-color = "#D8DEE9B2";
      text-caps-lock-color = "#D8DEE9B2";
      text-ver-color = "#D8DEE9B2";
      text-clear-color = "#D8DEE9B2";
      text-wrong-color = "#BF616AB2";
      ring-wrong-color = "#BF616AB2";
      key-hl-color = "#88C0D0B2";
      line-ver-color = "#88C0D0B2";
      ring-ver-color = "#88C0D0B2";
      ring-clear-color = "#88C0D0B2";
      bs-hl-color = "#88C0D0B2";
    };
  };
}
