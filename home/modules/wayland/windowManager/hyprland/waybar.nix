{
  pkgs,
  themes,
  ...
}: let
  inherit (themes.colorscheme) xcolors;
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";

    settings = [
      {
        layer = "top";
        position = "left";
        exclusive = true;
        fixed-center = true;
        gtk-layer-shell = true;
        spacing = 0;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-left = ["custom/logo" "hyprland/workspaces"];
        modules-right = ["tray" "custom/notification" "group/network-pulseaudio-backlight-battery" "clock" "group/powermenu"];

        # Distro Logo
        "custom/logo" = {
          format = " ";
          tooltip = false;
        };

        # Workspaces
        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
          disable-scroll = true;
          on-click = "activate";
          format = "";
          persistent-workspaces = {
            "*" = 5;
          };
        };

        # Tray
        tray = {
          icon-size = 16;
          show-passive-items = true;
          spacing = 8;
        };

        # Notifications
        "custom/notification" = {
          exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
          return-type = "json";
          format = "{icon}";
          format-icons = {
            notification = "󰂚";
            none = "󰂜";
            dnd-notification = "󰂛";
            dnd-none = "󰪑";
            inhibited-notification = "󰂛";
            inhibited-none = "󰪑";
            dnd-inhibited-notification = "󰂛";
            dnd-inhibited-none = "󰪑";
          };
          on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
          on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
          tooltip = true;
          escape = true;
        };

        # Group
        "group/network-pulseaudio-backlight-battery" = {
          modules = [
            "network"
            "group/audio-slider"
            "group/light-slider"
            "battery"
          ];
          orientation = "inherit";
        };

        # Network
        network = {
          format-wifi = "󰖩";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "WiFi: {essid} ({signalStrength}%)\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-ethernet = "Ethernet: {ifname}\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };

        # Pulseaudio
        "group/audio-slider" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "audio-slider-child";
            transition-left-to-right = false;
          };
          modules = ["pulseaudio" "pulseaudio/slider"];
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "vertical";
        };
        pulseaudio = {
          format = "{icon}";
          format-bluetooth = "󰂯";
          format-muted = "󰖁";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
          tooltip-format = "Volume: {volume}%";
          on-click = "${pkgs.pamixer}/bin/pamixer --toggle-mute";
          on-scroll-up = "${pkgs.pamixer}/bin/pamixer --decrease 1";
          on-scroll-down = "${pkgs.pamixer}/bin/pamixer --increase 1";
        };

        # Backlight
        "group/light-slider" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "light-slider-child";
            transition-left-to-right = false;
          };
          modules = ["backlight" "backlight/slider"];
        };
        "backlight/slider" = {
          min = 0;
          max = 100;
          orientation = "vertical";
        };
        backlight = {
          format = "{icon}";
          format-icons = ["󰝦" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
          tooltip-format = "Backlight: {percent}%";
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 1%-";
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set +1%";
        };

        # Battery
        battery = {
          format = "{icon}";
          format-charging = "󱐋";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-plugged = "󰚥";
          states = {
            warning = 30;
            critical = 20;
          };
          tooltip-format = "{timeTo}, {capacity}%";
        };

        # Clock & Calendar
        clock = {
          format = "{:%H\n%M}";
          actions = {
            on-scroll-down = "shift_down";
            on-scroll-up = "shift_up";
          };
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            format = {
              days = "<span color='${xcolors.gray1}'><b>{}</b></span>";
              months = "<span color='${xcolors.white}'><b>{}</b></span>";
              today = "<span color='${xcolors.white}'><b><u>{}</u></b></span>";
              weekdays = "<span color='${xcolors.blue}'><b>{}</b></span>";
            };
            mode = "month";
            on-scroll = 1;
          };
        };

        # Powermenu
        "group/powermenu" = {
          drawer = {
            children-class = "powermenu-child";
            transition-duration = 300;
            transition-left-to-right = false;
          };
          modules = [
            "custom/power"
            "custom/exit"
            "custom/lock"
            "custom/suspend"
            "custom/reboot"
          ];
          orientation = "inherit";
        };
        "custom/power" = {
          format = "󰐥";
          on-click = "${pkgs.systemd}/bin/systemctl poweroff";
          tooltip = false;
        };
        "custom/exit" = {
          format = "󰈆";
          on-click = "${pkgs.systemd}/bin/loginctl terminate-user $USER";
          tooltip = false;
        };
        "custom/lock" = {
          format = "󰌾";
          on-click = "${pkgs.systemd}/bin/loginctl lock-session";
          tooltip = false;
        };
        "custom/suspend" = {
          format = "󰤄";
          on-click = "${pkgs.systemd}/bin/systemctl suspend";
          tooltip = false;
        };
        "custom/reboot" = {
          format = "󰜉";
          on-click = "${pkgs.systemd}/bin/systemctl reboot";
          tooltip = false;
        };
      }
    ];

    style = let
      snowflake = builtins.fetchurl rec {
        name = "Logo-${sha256}.svg";
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
        sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
      };
    in ''
      * {
        all: unset;
        font: 11pt "Material Design Icons", Inter, sans-serif;
        min-height: 0;
        min-width: 0;
      }

      menu,
      tooltip {
        background: ${xcolors.black0};
        border: 1px solid ${xcolors.gray1};
        border-radius: 0.5rem;
        padding: 0.5rem;
      }

      menu {
        padding: 0;
      }

      menu label,
      tooltip label {
        padding: 0.5rem;
      }

      button {
        box-shadow: inset 0 -0.25rem transparent;
        border: none;
      }

      button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
      }

      slider {
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
      }

      trough {
        min-height: 5rem;
        min-width: 0.625rem;
        border-radius: 0.5rem;
        background-color: ${xcolors.black0};
      }

      highlight {
        min-width: 0.625rem;
        border-radius: 0.5rem;
      }

      window#waybar {
        background: alpha(#000000, 0.5);
        color: ${xcolors.white};
      }

      .modules-left {
        padding-top: 0.5rem;
      }

      .modules-right {
        padding-bottom: 0.5rem;
      }

      #custom-logo,
      #workspaces,
      #tray,
      #custom-notification,
      #network-pulseaudio-backlight-battery,
      #clock,
      #custom-exit,
      #custom-lock,
      #custom-suspend,
      #custom-reboot,
      #custom-power {
        background: alpha(#ffffff, 0.05);
        border: 1px solid alpha(#ffffff, 0.1);
        border-radius: 1.5rem;
        min-width: 0.75rem;
        margin: 0.25rem 0.5rem;
      }

      #tray,
      #custom-notification,
      #network-pulseaudio-backlight-battery,
      #clock {
        padding: 0.5rem 0;
      }

      #network,
      #pulseaudio,
      #pulseaudio-slider,
      #backlight,
      #backlight-slider,
      #battery {
        background: transparent;
        padding: 0.25rem 0.5rem;
      }

      #custom-logo,
      #custom-exit,
      #custom-lock,
      #custom-suspend,
      #custom-reboot,
      #custom-power {
        padding: 0.5rem;
      }

      #custom-logo {
        background: transparent
          url("${snowflake}")
          center/2rem no-repeat;
        border: none;
      }

      #workspaces {
        padding: 0.75rem 0.5rem;
      }

      #workspaces button {
        background: ${xcolors.white};
        border-radius: 1rem;
        margin-bottom: 0.75rem;
        transition: all 0.5s steps(12);
      }

      #workspaces button:last-child {
        margin-bottom: 0;
      }

      #workspaces button:hover {
        background: alpha(${xcolors.white}, 0.5);
      }

      #workspaces button.empty {
        background: ${xcolors.gray1};
      }

      #workspaces button.empty:hover {
        background: alpha(${xcolors.gray1}, 0.5);
      }

      #workspaces button.urgent {
        background: ${xcolors.red};
      }

      #workspaces button.urgent:hover {
        background: alpha(${xcolors.red}, 0.5);
      }

      #workspaces button.special {
        background: ${xcolors.yellow};
      }

      #workspaces button.special:hover {
        background: alpha(${xcolors.yellow}, 0.5);
      }

      #workspaces button.active {
        background: ${xcolors.blue};
      }

      #workspaces button.active:hover {
        background: alpha(${xcolors.blue}, 0.5);
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: ${xcolors.red};
      }

      #tray menu menuitem {
        border-radius: 0.5rem;
        color: ${xcolors.white};
        padding: 0.25rem;
      }

      #tray menu menuitem:hover {
        background: ${xcolors.blue};
        color: ${xcolors.black0};
      }

      #custom-notification {
        color: ${xcolors.yellow};
      }

      #network.disconnected,
      #pulseaudio.muted {
        color: ${xcolors.red};
      }

      #backlight-slider highlight,
      #pulseaudio-slider highlight {
        background-color: ${xcolors.white};
      }

      #battery.charging,
      #battery.plugged {
        color: ${xcolors.green};
      }

      #battery.critical:not(.charging) {
        color: ${xcolors.red};
        animation: blink 0.5s steps(12) infinite alternate;
      }

      #custom-exit {
        color: ${xcolors.blue};
      }

      #custom-lock {
        color: ${xcolors.green};
      }

      #custom-suspend {
        color: ${xcolors.yellow};
      }

      #custom-reboot {
        color: ${xcolors.peach};
      }

      #custom-power {
        color: ${xcolors.red};
      }

      @keyframes blink {
        to {
          color: ${xcolors.white};
        }
      }
    '';
  };
}
