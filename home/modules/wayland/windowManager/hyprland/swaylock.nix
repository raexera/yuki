{
  pkgs,
  themes,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = let
      inherit (themes.colorscheme) UI;
    in {
      clock = true;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      line-uses-inside = true;
      line-uses-ring = false;
      ignore-empty-password = false;
      show-failed-attempts = false;
      font = "Inter";
      timestr = "%I:%M %p";
      datestr = "%d / %m / %y";
      fade-in = "0.1";
      effect-blur = "10x5";

      ring-color = "${UI.secondaryBackground}";
      line-color = "${UI.background}";
      inside-color = "${UI.background}";
      inside-ver-color = "${UI.background}";
      inside-wrong-color = "${UI.background}";
      inside-clear-color = "${UI.background}";
      line-clear-color = "${UI.background}";
      line-wrong-color = "${UI.background}";
      text-color = "${UI.foreground}";
      text-caps-lock-color = "${UI.foreground}";
      text-ver-color = "${UI.foreground}";
      text-clear-color = "${UI.foreground}";
      text-wrong-color = "${UI.error}";
      ring-wrong-color = "${UI.error}";
      key-hl-color = "${UI.accent}";
      line-ver-color = "${UI.accent}";
      ring-ver-color = "${UI.accent}";
      ring-clear-color = "${UI.accent}";
      bs-hl-color = "${UI.accent}";
      separator-color = "${UI.accent}";
    };
  };
}
