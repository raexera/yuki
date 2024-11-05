{
  pkgs,
  themes,
  ...
}: let
  inherit (themes.colorscheme) xcolors;

  snowflake = builtins.fetchurl rec {
    name = "Logo-${sha256}.svg";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake-colours.svg";
    sha256 = "1cifj774r4z4m856fva1mamnpnhsjl44kw3asklrc57824f5lyz3";
  };
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";

    settings = [
      {
        layer = "top";
        position = "top";
        exclusive = true;
        fixed-center = true;
        gtk-layer-shell = true;
        spacing = 0;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-left = ["image" "hyprland/workspaces" "hyprland/window"];
        modules-center = ["custom/weather" "clock"];
        modules-right = ["tray" "group/network-wireplumber-backlight-battery" "group/powermenu"];

        "image" = {
          path = snowflake;
          size = 24;
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
          show-special = true;
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "hyprland/window" = {
          format = "{title}";
          icon = true;
          separate-outputs = true;
        };

        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          exec = "${pkgs.wttrbar}/bin/wttrbar  --hide-conditions --location Jakarta";
          return-type = "json";
        };

        clock = {
          format = "{:%b %d %H:%M}";
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

        tray = {
          icon-size = 16;
          show-passive-items = true;
          spacing = 8;
        };

        "group/network-wireplumber-backlight-battery" = {
          modules = [
            "network"
            "wireplumber"
            "backlight"
            "battery"
          ];
          orientation = "inherit";
        };

        network = {
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-disconnected = "";
          tooltip-format-wifi = "WiFi: {essid} ({signalStrength}%)\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-ethernet = "Ethernet: {ifname}\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };

        wireplumber = {
          format = "{icon}";
          format-muted = "󰖁";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle &> /dev/null";
          on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 1%+ &> /dev/null";
          on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 1%- &> /dev/null";
          tooltip-format = "Volume: {volume}%";
        };

        backlight = {
          format = "{icon}";
          format-icons = ["󰝦" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 1%+ &> /dev/null";
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 1%- &> /dev/null";
          tooltip-format = "Backlight: {percent}%";
        };

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

        "group/powermenu" = {
          drawer = {
            children-class = "powermenu-child";
            transition-duration = 300;
            transition-left-to-right = false;
          };
          modules = [
            "custom/power"
            "custom/lock"
            "custom/suspend"
            "custom/hibernate"
            "custom/exit"
            "custom/reboot"
          ];
          orientation = "inherit";
        };
        "custom/power" = {
          format = "󰐥";
          on-click = "${pkgs.systemd}/bin/systemctl poweroff";
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
        "custom/hibernate" = {
          format = "󰜗";
          on-click = "${pkgs.systemd}/bin/systemctl hibernate";
          tooltip = false;
        };
        "custom/exit" = {
          format = "󰍃";
          on-click = "${pkgs.systemd}/bin/loginctl terminate-user $USER";
          tooltip = false;
        };
        "custom/reboot" = {
          format = "󰜉";
          on-click = "${pkgs.systemd}/bin/systemctl reboot";
          tooltip = false;
        };
      }
    ];

    style = ''
      /* Global */
      * {
        all: unset;
        font-family: "JetBrainsMono NFP", sans-serif;
        font-size: 11pt;
        font-weight: 500;
      }

      /* Menu */
      menu {
        background: ${xcolors.black0};
        border-radius: 8px;
      }

      menu separator {
        background: ${xcolors.black3};
      }

      menu menuitem {
        background: transparent;
        padding: 0.5rem;
        transition: 200ms;
      }

      menu menuitem:hover {
        background: lighter(${xcolors.black3});
      }

      menu menuitem:first-child {
        border-radius: 8px 8px 0 0;
      }

      menu menuitem:last-child {
        border-radius: 0 0 8px 8px;
      }

      menu menuitem:only-child {
        border-radius: 8px;
      }

      /* Scale and Progress Bars */
      scale trough,
      progressbar trough {
        background: ${xcolors.black0};
        border-radius: 16px;
        min-width: 5rem;
      }

      scale highlight,
      scale progress,
      progressbar highlight,
      progressbar progress {
        background: ${xcolors.black3};
        border-radius: 16px;
        min-height: 0.5rem;
      }

      /* Tooltip */
      tooltip {
        background: ${xcolors.black0};
        border-radius: 16px;
      }

      tooltip label {
        margin: 0.5rem;
      }

      /* Waybar */
      window#waybar {
        background: ${xcolors.black0};
      }

      .modules-left {
        padding-left: 0.5rem;
      }

      .modules-right {
        padding-right: 0.5rem;
      }

      /* Modules */
      #workspaces,
      #workspaces button,
      #custom-weather,
      #clock,
      #network-wireplumber-backlight-battery,
      #custom-exit,
      #custom-lock,
      #custom-hibernate,
      #custom-suspend,
      #custom-reboot,
      #custom-power {
        background: ${xcolors.black3};
        border-radius: 8px;
        margin: 0.25rem;
        padding: 0.25rem;
      }

      #image,
      #window,
      #custom-weather,
      #clock,
      #tray,
      #network-wireplumber-backlight-battery {
        padding: 0.25rem 0.75rem;
      }

      #network,
      #wireplumber,
      #backlight,
      #battery {
        background: transparent;
        font-size: 13pt;
        margin-right: 0.75rem;
      }

      #battery {
        margin-right: 0;
      }

      #custom-exit,
      #custom-lock,
      #custom-hibernate,
      #custom-suspend,
      #custom-reboot,
      #custom-power {
        background: ${xcolors.blue};
        color: ${xcolors.black3};
        font-size: 13pt;
        min-width: 1.5rem;
      }

      /* Hyprland Workspaces */
      #workspaces {
        padding: 0;
      }

      #workspaces button {
        margin: 0;
        min-width: 1.5rem;
        transition: 300ms linear;
      }

      #workspaces button label {
        color: ${xcolors.white};
      }

      #workspaces button:hover label {
        color: lighter(${xcolors.white});
      }

      #workspaces button.empty label {
        color: ${xcolors.gray0};
      }

      #workspaces button.empty:hover label {
        color: lighter(${xcolors.gray0});
      }

      #workspaces button.urgent label {
        color: ${xcolors.red};
      }

      #workspaces button.urgent:hover label {
        color: lighter(${xcolors.red});
      }

      #workspaces button.special label {
        color: ${xcolors.mauve};
      }

      #workspaces button.special:hover label {
        color: lighter(${xcolors.mauve});
      }

      #workspaces button.active {
        background: ${xcolors.blue};
      }

      #workspaces button.active label {
        color: ${xcolors.black3};
      }

      #workspaces button.active:hover {
        background: lighter(${xcolors.blue});
      }

      #workspaces button.active:hover label {
        color: lighter(${xcolors.black3});
      }

      /* Systray */
      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background: ${xcolors.red};
      }

      /* Network */
      #network.disconnected {
        color: ${xcolors.red};
      }

      /* Wireplumber */
      #wireplumber.muted {
        color: ${xcolors.red};
      }

      /* Battery */
      #battery.charging,
      #battery.plugged {
        color: ${xcolors.green};
      }

      #battery.critical:not(.charging) {
        color: ${xcolors.red};
        animation: blink 0.5s steps(12) infinite alternate;
      }

      /* Keyframes */
      @keyframes blink {
        to {
          color: ${xcolors.white};
        }
      }
    '';
  };
}
