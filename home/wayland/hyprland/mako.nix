{
  config,
  lib,
  pkgs,
  ...
}: let
  theme = import ../../../theme/theme.nix {};
in {
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

    backgroundColor = "#${theme.colors.base}";
    textColor = "#${theme.colors.text}";
    borderColor = "#${theme.colors.mauve}";
    progressColor = "over  #${theme.colors.mauve}";

    extraConfig = ''
      [urgency=low]
      border-color=#${theme.colors.mauve}
      default-timeout=2000

      [urgency=normal]
      border-color=#${theme.colors.mauve}
      default-timeout=5000

      [urgency=high]
      border-color=#${theme.colors.red}
      text-color=#${theme.colors.red}
      default-timeout=0

      [category=mpd]
      border-color=#${theme.colors.yellow}
      default-timeout=2000
      group-by=category
    '';
  };
}
