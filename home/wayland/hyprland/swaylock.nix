{
  pkgs,
  lib,
  config,
  inputs,
  theme,
  ...
}: {
  home.packages = with pkgs; [swaylock-effects];

  programs.swaylock = {
    settings = {
      clock = true;
      color = "${theme.xcolors.base}";
      font = "Work Sans";
      show-failed-attempts = false;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      line-color = "${theme.xcolors.base}";
      ring-color = "626880";
      inside-color = "${theme.xcolors.base}";
      key-hl-color = "${theme.xcolors.mauve}";
      separator-color = "00000000";
      text-color = "${theme.xcolors.text}";
      text-caps-lock-color = "";
      line-ver-color = "${theme.xcolors.mauve}";
      ring-ver-color = "${theme.xcolors.mauve}";
      inside-ver-color = "${theme.xcolors.base}";
      text-ver-color = "${theme.xcolors.text}";
      ring-wrong-color = "${theme.xcolors.red}";
      text-wrong-color = "${theme.xcolors.red}";
      inside-wrong-color = "${theme.xcolors.base}";
      inside-clear-color = "${theme.xcolors.base}";
      text-clear-color = "${theme.xcolors.text}";
      ring-clear-color = "${theme.xcolors.green}";
      line-clear-color = "${theme.xcolors.base}";
      line-wrong-color = "${theme.xcolors.base}";
      bs-hl-color = "${theme.xcolors.red}";
      line-uses-ring = false;
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;
      datestr = "%d.%m";
      fade-in = "0.1";
      ignore-empty-password = true;
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
      }
      {
        timeout = 310;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
    ];
  };

  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];
}
