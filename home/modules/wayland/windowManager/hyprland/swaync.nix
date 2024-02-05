{pkgs, ...}: {
  services.swaync = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";
    schema = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";

    settings = {
      positionX = "right";
      positionY = "top";
      control-center-positionX = "left";
      control-center-positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
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
        label = {
          max-lines = 5;
          text = "Label Text";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
      };
    };

    style = ''
      * {
        all: unset;
        font: 11pt "Material Design Icons", Inter, sans-serif;
        transition: 200ms;
      }

      .notification-row {
        outline: none;
      }

      .notification-row .notification-background {
        padding: 6px 12px;
      }

      .notification-row .notification-background .notification {
        border-radius: 1rem;
        border: 1px solid alpha(#ffffff, 0.1);
        padding: 0.5rem;
        transition: background 0.15s ease-in-out;
        background: alpha(#000000, 0.5);
      }

      .control-center {
        background: alpha(#000000, 0.5);
        border-radius: 1rem;
        color: #ffffff;
      }

      .control-center .control-center-list-placeholder {
        opacity: 0.5;
      }

      .control-center .control-center-list {
        background: transparent;
      }

      .control-center .control-center-list .notification .notification-default-action,
      .control-center .control-center-list .notification .notification-action {
        transition: opacity 400ms ease-in-out, background 0.15s ease-in-out;
      }

      .blank-window,
      .floating-notifications {
        background: transparent;
      }

      .floating-notifications .notification {
        box-shadow: none;
      }

      /*** Widgets ***/
      /* Title widget */
      .widget-title {
        color: rgb(255, 255, 255);
        margin: 8px;
        font-size: 1.5rem;
      }

      .widget-title > button {
        font-size: initial;
        color: rgb(255, 255, 255);
        text-shadow: none;
        background: rgba(48, 48, 48, 0.8);
        border: 1px solid rgba(255, 255, 255, 0.15);
        box-shadow: none;
        border-radius: 12px;
      }

      .widget-title > button:hover {
        background: rgb(56, 56, 56);
      }

      /* DND widget */
      .widget-dnd {
        color: rgb(255, 255, 255);
        margin: 8px;
        font-size: 1.1rem;
      }

      .widget-dnd > switch {
        font-size: initial;
        border-radius: 12px;
        background: rgba(48, 48, 48, 0.8);
        border: 1px solid rgba(255, 255, 255, 0.15);
        box-shadow: none;
      }

      .widget-dnd > switch:checked {
        background: rgb(0, 128, 255);
      }

      .widget-dnd > switch slider {
        background: rgb(56, 56, 56);
        border-radius: 12px;
      }

      /* Label widget */
      .widget-label {
        margin: 8px;
      }

      .widget-label > label {
        font-size: 1.1rem;
      }

      /* Mpris widget */
      .widget-mpris {
        /* The parent to all players */
      }

      .widget-mpris .widget-mpris-player {
        padding: 8px;
        padding: 16px;
        margin: 16px 20px;
        background-color: rgba(0, 0, 0, 0.55);
        border-radius: 12px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.75);
      }

      .widget-mpris .widget-mpris-player button:hover {
        /* The media player buttons (play, pause, next, etc...) */
        background: rgb(56, 56, 56);
      }

      .widget-mpris .widget-mpris-player .widget-mpris-album-art {
        border-radius: 12px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.75);
      }

      .widget-mpris .widget-mpris-player .widget-mpris-title {
        font-weight: bold;
        font-size: 1.25rem;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-subtitle {
        font-size: 1.1rem;
      }

      .widget-mpris .widget-mpris-player > box > button {
        /* Change player control buttons */
      }

      .widget-mpris .widget-mpris-player > box > button:hover {
        background-color: rgba(0, 0, 0, 0.5);
      }

      .widget-mpris > box > button {
        /* Change player side buttons */
      }

      .widget-mpris > box > button:disabled {
        /* Change player side buttons insensitive */
      }

      /* Inhibitors widget */
      .widget-inhibitors {
        margin: 8px;
        font-size: 1.5rem;
      }

      .widget-inhibitors > button {
        font-size: initial;
        color: rgb(255, 255, 255);
        text-shadow: none;
        background: rgba(48, 48, 48, 0.8);
        border: 1px solid rgba(255, 255, 255, 0.15);
        box-shadow: none;
        border-radius: 12px;
      }

      .widget-inhibitors > button:hover {
        background: rgb(56, 56, 56);
      }
    '';
  };
}
