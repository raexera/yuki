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
        position = "bottom";
        exclusive = true;
        fixed-center = true;
        gtk-layer-shell = true;
        spacing = 0;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-left = ["custom/ghost" "hyprland/workspaces" "hyprland/window"];
        modules-center = ["custom/weather" "clock"];
        modules-right = ["tray" "custom/notification" "group/network-pulseaudio-backlight-battery" "group/powermenu"];

        # Ghost
        "custom/ghost" = {
          format = "󱙝";
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

        # Window
        "hyprland/window" = {
          format = "{}";
          separate-outputs = true;
        };

        # Weather
        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          exec = "${pkgs.wttrbar}/bin/wttrbar --location 'Jakarta' --hide-conditions";
          return-type = "json";
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
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-disconnected = "";
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
            transition-left-to-right = true;
          };
          modules = ["pulseaudio" "pulseaudio/slider"];
        };
        pulseaudio = {
          format = "{icon}";
          format-bluetooth = "󰂯";
          format-muted = "󰖁";
          format-icons = {
            hands-free = "󱡏";
            headphone = "󰋋";
            headset = "󰋎";
            default = ["󰕿" "󰖀" "󰕾"];
          };
          tooltip-format = "Volume: {volume}%";
          on-click = "${pkgs.pamixer}/bin/pamixer --toggle-mute";
          on-scroll-up = "${pkgs.pamixer}/bin/pamixer --decrease 1";
          on-scroll-down = "${pkgs.pamixer}/bin/pamixer --increase 1";
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };

        # Backlight
        "group/light-slider" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "light-slider-child";
            transition-left-to-right = true;
          };
          modules = ["backlight" "backlight/slider"];
        };
        backlight = {
          format = "{icon}";
          format-icons = ["󰝦" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
          tooltip-format = "Backlight: {percent}%";
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 1%-";
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set +1%";
        };
        "backlight/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
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

    style = builtins.readFile (./. + "/style.css");
  };
}
