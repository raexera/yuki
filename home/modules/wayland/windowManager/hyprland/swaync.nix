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
          clear-all-button = true;
          button-text = "Clear All";
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

    style = ''
      * {
        font: 11pt Inter, sans-serif;
      }

      .notification {
        background: rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 1rem;
      }

      .control-center {
        background: rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 1rem;
      }

      .control-center .control-center-list {
        background: transparent;
      }

      .blank-window {
        background: transparent;
      }

      .floating-notifications {
        background: transparent;
      }

      .widget-mpris .widget-mpris-player {
        padding: 1rem;
        margin: 1rem;
        background-color: rgba(0, 0, 0, 0.6);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 1rem;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-album-art {
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 1rem;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-title {
        font-weight: bold;
        font-size: 1.25rem;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-subtitle {
        font-size: 1.1rem;
      }
    '';
  };
}
