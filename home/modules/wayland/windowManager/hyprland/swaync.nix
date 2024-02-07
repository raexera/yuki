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
      @define-color cc-bg rgba(23, 63, 79, 0.4);

      @define-color noti-text-color rgba(53, 185, 171, 1);
      @define-color noti-border-color rgba(53, 185, 171, 0.4);
      @define-color noti-bg rgba(23, 63, 79, 0.4);
      @define-color noti-bg-hover rgba(23, 63, 79, 1);
      @define-color noti-bg-focus rgba(23, 63, 79, 0.6);
      @define-color noti-close-bg rgba(255, 255, 255, 0.1);
      @define-color noti-close-bg-hover rgba(255, 255, 255, 0.15);

      @define-color bg-selected rgba(33, 164, 223, 1);

      * {
        all: unset;
        font:
          11pt Inter,
          sans-serif;
      }

      .notification-row {
        outline: none;
      }

      .notification-row:focus,
      .notification-row:hover {
        background: @noti-bg-focus;
      }

      .notification {
        border-radius: 12px;
        margin: 6px 12px;
        box-shadow:
          0 0 0 1px rgba(0, 0, 0, 0.3),
          0 1px 3px 1px rgba(0, 0, 0, 0.7),
          0 2px 6px 2px rgba(0, 0, 0, 0.3);
        padding: 0;
      }

      /* Uncomment to enable specific urgency colors
      .low {
        background: yellow;
        padding: 6px;
        border-radius: 12px;
      }

      .normal {
        background: green;
        padding: 6px;
        border-radius: 12px;
      }

      .critical {
        background: red;
        padding: 6px;
        border-radius: 12px;
      }
      */

      .notification-content {
        background: transparent;
        padding: 6px;
        border-radius: 12px;
      }

      .close-button {
        background: @noti-close-bg;
        color: @noti-text-color;
        text-shadow: none;
        padding: 0;
        border-radius: 100%;
        margin-top: 10px;
        margin-right: 16px;
        box-shadow: none;
        border: none;
        min-width: 24px;
        min-height: 24px;
      }

      .close-button:hover {
        box-shadow: none;
        background: @noti-close-bg-hover;
        transition: all 0.15s ease-in-out;
        border: none;
      }

      .notification-default-action,
      .notification-action {
        padding: 4px;
        margin: 0;
        box-shadow: none;
        background: @noti-bg;
        border: 1px solid @noti-border-color;
        color: white;
      }

      .notification-default-action:hover,
      .notification-action:hover {
        -gtk-icon-effect: none;
        background: @noti-bg-hover;
      }

      .notification-default-action {
        border-radius: 12px;
      }

      .notification-default-action:not(:only-child) {
        border-bottom-left-radius: 0px;
        border-bottom-right-radius: 0px;
      }

      .notification-action {
        border-radius: 0px;
        border-top: none;
        border-right: none;
      }

      .notification-action:first-child {
        border-bottom-left-radius: 10px;
      }

      .notification-action:last-child {
        border-bottom-right-radius: 10px;
        border-right: 1px solid @noti-border-color;
      }

      .body-image {
        margin-top: 6px;
        background-color: white;
        border-radius: 12px;
      }

      .summary {
        color: @noti-text-color;
        text-shadow: none;
      }

      .time {
        color: @noti-text-color;
        text-shadow: none;
        margin-right: 18px;
      }

      .body {
        background: transparent;
        color: @noti-text-color;
        text-shadow: none;
      }

      .control-center {
        background: @cc-bg;
        border: 1px solid alpha(#ffffff, 0.1);
        border-radius: 1rem;
      }

      .control-center > box {
      }

      .control-center-list {
        background: transparent;
      }

      .floating-notifications {
        background: transparent;
      }

      .blank-window {
        background: transparent;
      }
    '';
  };
}
