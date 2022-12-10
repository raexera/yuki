{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  home.packages = with pkgs; [swaylock-effects];

  programs.swaylock = {
    settings = with colors; {
      clock = true;
      color = "#${base01}";
      font = "Inter";
      show-failed-attempts = false;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      line-color = "#${base01}";
      ring-color = "#${base00}";
      inside-color = "#${base01}";
      key-hl-color = "#${base0C}";
      separator-color = "00000000";
      text-color = "#${base06}";
      text-caps-lock-color = "";
      line-ver-color = "#${base0C}";
      ring-ver-color = "#${base0C}";
      inside-ver-color = "#${base01}";
      text-ver-color = "#${base06}";
      ring-wrong-color = "#${base0B}";
      text-wrong-color = "#${base0B}";
      inside-wrong-color = "#${base01}";
      inside-clear-color = "#${base01}";
      text-clear-color = "#${base06}";
      ring-clear-color = "#${base0D}";
      line-clear-color = "#${base01}";
      line-wrong-color = "#${base01}";
      bs-hl-color = "#${base0B}";
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
