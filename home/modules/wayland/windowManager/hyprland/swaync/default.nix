{pkgs, ...}: {
  services.swaync = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";
    schema = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";

    settings = {
      # General settings
      cssPriority = "user";
      image-visibility = "when-available";
      keyboard-shortcut = true;
      relative-timestamps = true;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      script-fail-notify = true;
      transition-time = 200;

      # Layer settings
      layer-shell = true;
      layer = "overlay";
      control-center-layer = "overlay";

      # Notification settings
      positionX = "center";
      positionY = "top";
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-window-width = 300;

      # Control center settings
      control-center-positionX = "right";
      control-center-positionY = "top";
      control-center-margin-top = 4;
      control-center-margin-bottom = 4;
      control-center-margin-left = 0;
      control-center-margin-right = 4;
      control-center-width = 500;
      control-center-exclusive-zone = true;
      fit-to-screen = true;
      hide-on-action = true;
      hide-on-clear = false;

      # Widget settings
      widgets = [
        "title"
        "dnd"
        "notifications"
        "mpris"
      ];

      # Widget config
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
          blur = true;
        };
      };
    };

    # Custom style
    style = builtins.readFile (./. + "/style.css");
  };
}
