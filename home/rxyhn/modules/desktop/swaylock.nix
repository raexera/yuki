{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [swaylock-effects];

  programs.swaylock = {
    settings = {
      screenshots = true;
      clock = true;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;
      line-uses-ring = false;
      ignore-empty-password = true;
      show-failed-attempts = false;

      font = "Inter";
      timestr = "%I:%M %p";
      datestr = "%d / %m / %y";
      fade-in = "0.2";
      effect-blur = "8x5";
      effect-vignette = "0.5:0.5";

      color = "00000000";

      bs-hl-color = "#f38ba8";
      key-hl-color = "#cba6f7";

      inside-color = "#1e1e2e";
      inside-clear-color = "#1e1e2e";
      inside-ver-color = "#1e1e2e";
      inside-wrong-color = "#1e1e2e";

      line-color = "#11111b";
      line-ver-color = "#11111b";
      line-clear-color = "#11111b";
      line-wrong-color = "#11111b";

      ring-color = "#181825";
      ring-clear-color = "#cba6f7";
      ring-ver-color = "#cba6f7";
      ring-wrong-color = "#f38ba8";

      separator-color = "00000000";

      text-color = "#cdd6f4";
      text-clear-color = "#cdd6f4";
      text-ver-color = "#cdd6f4";
      text-wrong-color = "#f38ba8";
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
