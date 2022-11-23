{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  theme = import ../../theme/theme.nix {};
in {
  home.packages = with pkgs; [swaylock-effects];

  programs.swaylock = {
    settings = {
      clock = true;
      color = "${theme.colors.base}";
      font = "Work Sans";
      show-failed-attempts = false;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      line-color = "${theme.colors.base}";
      ring-color = "626880";
      inside-color = "${theme.colors.base}";
      key-hl-color = "${theme.colors.mauve}";
      separator-color = "00000000";
      text-color = "${theme.colors.text}";
      text-caps-lock-color = "";
      line-ver-color = "${theme.colors.mauve}";
      ring-ver-color = "${theme.colors.mauve}";
      inside-ver-color = "${theme.colors.base}";
      text-ver-color = "${theme.colors.text}";
      ring-wrong-color = "${theme.colors.red}";
      text-wrong-color = "${theme.colors.red}";
      inside-wrong-color = "${theme.colors.base}";
      inside-clear-color = "${theme.colors.base}";
      text-clear-color = "${theme.colors.text}";
      ring-clear-color = "${theme.colors.green}";
      line-clear-color = "${theme.colors.base}";
      line-wrong-color = "${theme.colors.base}";
      bs-hl-color = "${theme.colors.red}";
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
