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

      ring-color = "${xcolors.base00}33";
      line-color = "${xcolors.base00}66";
      inside-color = "${xcolors.base00}66";
      inside-ver-color = "${xcolors.base00}66";
      inside-wrong-color = "${xcolors.base00}66";
      inside-clear-color = "${xcolors.base00}66";
      line-clear-color = "${xcolors.base00}66";
      line-wrong-color = "${xcolors.base00}66";
      text-color = "${xcolors.base05}CC";
      text-caps-lock-color = "${xcolors.base05}CC";
      text-ver-color = "${xcolors.base05}CC";
      text-clear-color = "${xcolors.base05}CC";
      text-wrong-color = "${xcolors.base08}CC";
      ring-wrong-color = "${xcolors.base08}CC";
      key-hl-color = "${xcolors.base0C}CC";
      line-ver-color = "${xcolors.base0C}CC";
      ring-ver-color = "${xcolors.base0C}CC";
      ring-clear-color = "${xcolors.base0C}CC";
      bs-hl-color = "${xcolors.base0C}CC";
    };
  };
}
