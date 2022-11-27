{
  config,
  lib,
  pkgs,
  theme,
  ...
}: {
  programs.mako = {
    enable = true;
    anchor = "top-right";
    width = 350;
    height = 250;
    margin = "15";
    padding = "15,30,15,30";
    borderRadius = 12;
    borderSize = 4;
    icons = true;
    maxIconSize = 48;
    defaultTimeout = 5000;
    font = "monospace 15";
    layer = "top";
    maxVisible = 5;

    backgroundColor = theme.xcolors.base;
    textColor = theme.xcolors.text;
    borderColor = theme.xcolors.mauve;
    progressColor = "over ${theme.xcolors.mauve}";

    extraConfig = ''
      [urgency=low]
      border-color=${theme.xcolors.mauve}
      default-timeout=2000

      [urgency=normal]
      border-color=${theme.xcolors.mauve}
      default-timeout=5000

      [urgency=high]
      border-color=${theme.xcolors.red}
      text-color=${theme.xcolors.red}
      default-timeout=0

      [category=mpd]
      border-color=${theme.xcolors.yellow}
      default-timeout=2000
      group-by=category
    '';
  };
}
