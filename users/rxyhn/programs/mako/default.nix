{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.mako = {
    enable = true;
    anchor = "top-right";
    width = 350;
    height = 250;
    margin = "15";
    padding = "15,30,15,30";
    borderSize = 4;
    borderRadius = 12;
    font = "monospace 12";
    backgroundColor = "#303446";
    textColor = "#c6d0f5";
    borderColor = "#8caaee";
    progressColor = "over #414559";
    maxIconSize = 48;
    defaultTimeout = 5000;

    extraConfig = ''
      [urgency=low]
      border-color=#414559
      default-timeout=2000

      [urgency=normal]
      border-color=#414559
      default-timeout=5000

      [urgency=high]
      border-color=#e78284
      text-color=#e78284
      default-timeout=0

      [category=mpd]
      border-color=#e5c890
      default-timeout=2000
      group-by=category
    '';
  };
}
