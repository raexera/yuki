{
  config,
  pkgs,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = let
      xcolors = pkgs.lib.colors.xcolors config.colorscheme.colors;
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
      effect-blur = "20x5";

      ring-color = "${xcolors.background}33";
      line-color = "${xcolors.background}66";
      inside-color = "${xcolors.background}66";
      inside-ver-color = "${xcolors.background}66";
      inside-wrong-color = "${xcolors.background}66";
      inside-clear-color = "${xcolors.background}66";
      line-clear-color = "${xcolors.background}66";
      line-wrong-color = "${xcolors.background}66";
      text-color = "${xcolors.foreground}CC";
      text-caps-lock-color = "${xcolors.foreground}CC";
      text-ver-color = "${xcolors.foreground}CC";
      text-clear-color = "${xcolors.foreground}CC";
      text-wrong-color = "${xcolors.color1}CC";
      ring-wrong-color = "${xcolors.color1}CC";
      key-hl-color = "${xcolors.color4}CC";
      line-ver-color = "${xcolors.color4}CC";
      ring-ver-color = "${xcolors.color4}CC";
      ring-clear-color = "${xcolors.color4}CC";
      bs-hl-color = "${xcolors.color4}CC";
    };
  };
}
