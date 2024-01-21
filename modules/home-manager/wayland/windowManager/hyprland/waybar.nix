{
  lib,
  pkgs,
  themes,
  ...
}: let
  _ = lib.getExe;
  inherit (pkgs) brightnessctl pamixer;

  snowflake = builtins.fetchurl rec {
    name = "Logo-${sha256}.svg";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
    sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
  };

  inherit (themes.colorscheme) xcolors;
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        exclusive = true;
        fixed-center = true;
        gtk-layer-shell = true;
        spacing = 0;
        margin-top = 5;
        margin-bottom = 5;
        margin-left = 5;
        margin-right = 0;
        modules-left = [
          "custom/logo"
          "hyprland/workspaces"
        ];
        modules-center = [];
        modules-right = [
          "group/network-pulseaudio-backlight-battery"
          "clock"
          "group/powermenu"
        ];

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
          format = "{icon}";
          format-icons = {
            active = "󰋘";
            default = "󰋙";
            empty = "󰋙";
            persistent = "󰋙";
            special = "󰋙";
            urgent = "󰋙";
          };
          persistent-workspaces = {
            "*" = 5;
          };
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
          on-click = "${_ pamixer} -t";
          on-scroll-up = "${_ pamixer} -d 1";
          on-scroll-down = "${_ pamixer} -i 1";
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
          on-scroll-up = "${_ brightnessctl} -q s 1%-";
          on-scroll-down = "${_ brightnessctl} -q s +1%";
        };

        # Battery
        battery = {
          format = "{icon}";
          format-charging = "󱐋";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-plugged = "󰚥";
          states = {
            warning = 30;
            critical = 15;
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
              days = "<span color='#4A5051'><b>{}</b></span>";
              months = "<span color='#C5C8C9'><b>{}</b></span>";
              today = "<span color='#C5C8C9'><b><u>{}</u></b></span>";
              weekdays = "<span color='#96CDFB'><b>{}</b></span>";
            };
            mode = "month";
            on-scroll = 1;
          };
        };

        # Powermenu
        "group/powermenu" = {
          drawer = {
            children-class = "power-child";
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
        "custom/exit" = {
          format = "󰈆";
          on-click = "${pkgs.hyprland}/bin/hyprctl dispatch exit";
          tooltip = false;
        };
        "custom/lock" = {
          format = "󰌾";
          on-click = "${pkgs.swaylock-effects}/bin/swaylock -S --daemonize";
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
        "custom/power" = {
          format = "󰐥";
          on-click = "${pkgs.systemd}/bin/systemctl poweroff";
          tooltip = false;
        };
      };
    };

    style = ''
      * {
        all: unset;
        font: 1rem "Material Design Icons", "Iosevka Fixed", sans-serif;
        min-height: 0;
        min-width: 0;
      }

      label {
        color: ${xcolors.white};
      }

      menu,
      tooltip {
        background: ${xcolors.black0};
        border: 1px solid ${xcolors.gray1};
        border-radius: 0.5rem;
        padding: 0.5rem;
      }

      menu label,
      tooltip label {
        padding: 1rem;
      }

      button {
        box-shadow: inset 0 -3px transparent;
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
        background: ${xcolors.black0};
        border-radius: 0.5rem;
        color: ${xcolors.white};
      }

      .modules-left {
        padding-top: 0.5rem;
      }

      .modules-right {
        padding-bottom: 0.5rem;
      }

      #clock,
      #custom-lock,
      #custom-logo,
      #custom-exit,
      #custom-power,
      #custom-reboot,
      #custom-suspend,
      #network-pulseaudio-backlight-battery,
      #workspaces {
        background: ${xcolors.black3};
        border-radius: 1rem;
        margin: 0.25rem 0.5rem;
        padding: 1rem 0.5rem;
      }

      #custom-logo {
        background: transparent
          url("${snowflake}")
          center/2rem no-repeat;
        padding: 0.5rem;
      }

      #network-pulseaudio-backlight-battery,
      #workspaces {
        padding: 1rem 0;
      }

      #network,
      #pulseaudio,
      #pulseaudio-slider,
      #backlight,
      #backlight-slider,
      #battery,
      #workspaces button {
        padding: 0.375rem 0.5rem;
      }

      #workspaces button.empty label {
        color: ${xcolors.gray1};
      }

      #workspaces button.urgent label {
        color: ${xcolors.red};
      }

      #workspaces button.special label {
        color: ${xcolors.yellow};
      }

      #workspaces button.active label {
        color: ${xcolors.blue};
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
        animation: blink 0.5s linear infinite alternate;
      }

      #clock {
        font-weight: bold;
      }

      #custom-exit,
      #custom-lock,
      #custom-suspend,
      #custom-reboot,
      #custom-power {
        background: transparent;
        padding: 0.5rem;
      }

      #custom-power {
        color: ${xcolors.red};
      }

      #custom-reboot {
        color: ${xcolors.peach};
      }

      #custom-suspend {
        color: ${xcolors.yellow};
      }

      #custom-lock {
        color: ${xcolors.green};
      }

      #custom-exit {
        color: ${xcolors.blue};
      }

      @keyframes blink {
        to {
          color: ${xcolors.white};
        }
      }
    '';

    systemd.enable = true;
    systemd.target = "graphical-session.target";
  };
}
