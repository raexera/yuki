{
  pkgs,
  themes,
  ...
}: {
  services.swaync = {
    enable = true;
    systemd.enable = true;
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
    style = let
      inherit (themes.colorscheme) xcolors;
    in ''
      * {
        font: 11pt "Material Design Icons", Inter, sans-serif;
      }

      .blank-window {
        background: transparent;
      }

      .control-center {
        background: ${xcolors.black0};
        border-radius: 0.5rem;
        color: ${xcolors.white};
      }

      .control-center .control-center-list-placeholder {
        opacity: 0.5;
      }

      .control-center .control-center-list {
        background: transparent;
      }

      .notification-row {
        transition: all 0.5s steps(12);
      }
    '';
  };
}
