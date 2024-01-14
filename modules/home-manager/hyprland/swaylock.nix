{
  pkgs,
  themes,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = let
      xcolors = pkgs.lib.colors.xcolors themes.colorscheme.colors;
    in {
      clock = true;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      line-uses-inside = true;
      line-uses-ring = false;
      ignore-empty-password = true;
      show-failed-attempts = false;
      font = "Dosis";
      timestr = "%I:%M %p";
      datestr = "%d / %m / %y";
      fade-in = "0.1";
      effect-blur = "10x5";

      ring-color = "${xcolors.black3}";
      line-color = "${xcolors.black0}";
      inside-color = "${xcolors.black0}";
      inside-ver-color = "${xcolors.black0}";
      inside-wrong-color = "${xcolors.black0}";
      inside-clear-color = "${xcolors.black0}";
      line-clear-color = "${xcolors.black0}";
      line-wrong-color = "${xcolors.black0}";
      text-color = "${xcolors.white}";
      text-caps-lock-color = "${xcolors.white}";
      text-ver-color = "${xcolors.white}";
      text-clear-color = "${xcolors.white}";
      text-wrong-color = "${xcolors.red}";
      ring-wrong-color = "${xcolors.red}";
      key-hl-color = "${xcolors.blue}";
      line-ver-color = "${xcolors.blue}";
      ring-ver-color = "${xcolors.blue}";
      ring-clear-color = "${xcolors.blue}";
      bs-hl-color = "${xcolors.blue}";
      separator-color = "${xcolors.blue}";
    };
  };
}
