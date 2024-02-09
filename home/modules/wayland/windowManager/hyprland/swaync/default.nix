{pkgs, ...}: {
  services.swaync = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";
    schema = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";

    settings = {
      cssPriority = "application";
      layer-shell = true;
      layer = "overlay";
      control-center-layer = "top";
      positionX = "center";
      positionY = "top";
      control-center-positionX = "left";
      control-center-positionY = "top";
      control-center-margin-top = 4;
      control-center-margin-bottom = 4;
      control-center-margin-left = 4;
      control-center-margin-right = 0;
      control-center-exclusive-zone = true;
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = true;
      relative-timestamps = true;
      control-center-width = 500;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "notifications"
        "mpris"
      ];
      widget-config = {
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "Notifications";
          button-text = "Clear All";
          clear-all-button = true;
        };
        dnd = {
          text = "Do Not Disturb";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
      };
    };

    style = builtins.readFile (./. + "/style.css");
  };
}
