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
      ring-color = "#00000033";
      line-color = "#00000066";
      inside-color = "#00000066";
      inside-ver-color = "#00000066";
      inside-wrong-color = "#00000066";
      inside-clear-color = "#00000066";
      line-clear-color = "#00000066";
      line-wrong-color = "#00000066";
      text-color = "#FFFFFFCC";
      text-caps-lock-color = "#FFFFFFCC";
      text-ver-color = "#FFFFFFCC";
      text-clear-color = "#FFFFFFCC";
      text-wrong-color = "#BF616ACC";
      ring-wrong-color = "#BF616ACC";
      key-hl-color = "#88C0D0CC";
      line-ver-color = "#88C0D0CC";
      ring-ver-color = "#88C0D0CC";
      ring-clear-color = "#88C0D0CC";
      bs-hl-color = "#88C0D0CC";
    };
  };
}
