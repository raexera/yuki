{pkgs, ...}: {
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
        modules-left = ["custom/logo" "hyprland/workspaces" "hyprland/window"];
        modules-center = ["custom/weather" "clock"];
        modules-right = ["tray" "group/network-pulseaudio-backlight-battery" "group/powermenu"];

        "custom/logo" = {
          format = " ";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "";
          on-click = "activate";
          disable-scroll = true;
          all-outputs = true;
          show-special = true;
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "hyprland/window" = {
          format = "{}";
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
              days = "<span color='#98989d'><b>{}</b></span>";
              months = "<span color='#ffffff'><b>{}</b></span>";
              today = "<span color='#ffffff'><b><u>{}</u></b></span>";
              weekdays = "<span color='#0a84ff'><b>{}</b></span>";
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

        "group/network-pulseaudio-backlight-battery" = {
          modules = [
            "network"
            "group/audio-slider"
            "group/light-slider"
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
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake-colours.svg";
        sha256 = "1cifj774r4z4m856fva1mamnpnhsjl44kw3asklrc57824f5lyz3";
      };
    in ''
      @define-color foreground #D8DEE9;
      @define-color background #242933;
      @define-color background-alt #2E3440;
      @define-color background-focus #373E4C;
      @define-color accent #89C1D1;
      @define-color red #BF616A;
      @define-color green #A3BE8C;
      @define-color blue #81A1C1;
      @define-color gray #4C566A;

      /* Global */
      * {
        all: unset;
        color: @foreground;
        font:
          11pt "Material Design Icons",
          Inter,
          sans-serif;
      }

      /* Button */
      button {
        box-shadow: inset 0 -0.25rem transparent;
        border: none;
      }

      button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
      }

      /* Menu */
      menu {
        background: @background;
        border-radius: 8px;
      }

      menu separator {
        background: @background-alt;
      }

      menu menuitem {
        background: transparent;
        padding: 0.5rem;
        transition: 200ms;
      }

      menu menuitem:hover {
        background: @background-focus;
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
        background: @background;
        border-radius: 16px;
        min-width: 5rem;
      }

      scale highlight,
      scale progress,
      progressbar highlight,
      progressbar progress {
        background: @background-alt;
        border-radius: 16px;
        min-height: 0.5rem;
      }

      /* Tooltip */
      tooltip {
        background: @background;
        border-radius: 16px;
      }

      tooltip label {
        margin: 0.5rem;
      }

      /* Waybar */
      window#waybar {
        background: @background;
      }

      window#waybar.empty #window {
        background: transparent;
        border: none;
      }

      .modules-left {
        padding-left: 0.5rem;
      }

      .modules-right {
        padding-right: 0.5rem;
      }

      /* Modules */
      #custom-logo,
      #workspaces,
      #window,
      #tray,
      #custom-weather,
      #network-pulseaudio-backlight-battery,
      #clock,
      #custom-exit,
      #custom-lock,
      #custom-suspend,
      #custom-reboot,
      #custom-power {
        background: @background-alt;
        border-radius: 8px;
        margin: 0.5rem 0.25rem;
      }

      #custom-logo,
      #window,
      #custom-weather,
      #tray,
      #network-pulseaudio-backlight-battery,
      #clock {
        padding: 0 0.75rem;
      }

      #network,
      #pulseaudio,
      #pulseaudio-slider,
      #backlight,
      #backlight-slider,
      #battery {
        background: transparent;
        padding: 0.5rem;
      }

      #custom-exit,
      #custom-lock,
      #custom-suspend,
      #custom-reboot,
      #custom-power {
        background: @accent;
        color: @background-alt;
        padding: 0.5rem;
      }

      /* Custom Logo */
      #custom-logo {
        background: transparent
          url("${snowflake}")
          center/2rem no-repeat;
        min-width: 2rem;
      }

      /* Hyprland Workspaces */
      #workspaces {
        padding: 0.5rem 0.75rem;
      }

      #workspaces button {
        background: @foreground;
        border-radius: 100%;
        min-width: 1rem;
        margin-right: 0.75rem;
        transition: 200ms linear;
      }

      #workspaces button:last-child {
        margin-right: 0;
      }

      #workspaces button:hover {
        background: lighter(@foreground);
      }

      #workspaces button.empty {
        background: @gray;
      }

      #workspaces button.empty:hover {
        background: lighter(@gray);
      }

      #workspaces button.urgent {
        background: @red;
      }

      #workspaces button.urgent:hover {
        background: lighter(@red);
      }

      #workspaces button.special {
        background: @blue;
      }

      #workspaces button.special:hover {
        background: lighter(@blue);
      }

      #workspaces button.active {
        background: @accent;
      }

      #workspaces button.active:hover {
        background: lighter(@accent);
      }

      /* Hyprland Window */
      #window {
        min-width: 1rem;
      }

      /* Systray */
      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background: @red;
      }

      /* Network */
      #network.disconnected {
        color: @red;
      }

      /* Pulseaudio */
      #pulseaudio.muted {
        color: @red;
      }

      #pulseaudio-slider highlight,
      #backlight-slider highlight {
        background: @foreground;
      }

      /* Battery */
      #battery.charging,
      #battery.plugged {
        color: @green;
      }

      #battery.critical:not(.charging) {
        color: @red;
        animation: blink 0.5s steps(12) infinite alternate;
      }

      /* Keyframes */
      @keyframes blink {
        to {
          color: @foreground;
        }
      }
    '';
  };
}
