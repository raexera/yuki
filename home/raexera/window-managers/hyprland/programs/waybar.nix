{
  config,
  pkgs,
  ...
}: let
  inherit (config.theme.colorscheme) xcolors;
in {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
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
        modules-left = [
          "image"
          "hyprland/workspaces"
          "idle_inhibitor"
          "hyprland/window"
        ];
        modules-right = [
          "group/network-modules"
          "group/wireplumber-modules"
          "group/backlight-modules"
          "group/battery-modules"
          "tray"
          "clock"
          "group/powermenu"
        ];

        "image" = {
          path = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          size = 24;
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "{id}";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };

        "hyprland/window" = {
          format = "{title}";
          icon = true;
          icon-size = 24;
          separate-outputs = true;
        };

        "group/network-modules" = {
          modules = [
            "network#icon"
            "network#address"
          ];
          orientation = "inherit";
        };
        "network#icon" = {
          format-disconnected = "󰤮";
          format-ethernet = "󰈀";
          format-wifi = "󰤨";
          tooltip-format-wifi = "WiFi: {essid} ({signalStrength}%)\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-ethernet = "Ethernet: {ifname}\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };
        "network#address" = {
          format-disconnected = "Disconnected";
          format-ethernet = "{ipaddr}/{cidr}";
          format-wifi = "{essid}";
          tooltip-format-wifi = "WiFi: {essid} ({signalStrength}%)\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-ethernet = "Ethernet: {ifname}\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-disconnected = "Disconnected";
        };

        "group/wireplumber-modules" = {
          modules = [
            "wireplumber#icon"
            "wireplumber#volume"
          ];
          orientation = "inherit";
        };
        "wireplumber#icon" = {
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
        "wireplumber#volume" = {
          format = "{volume}%";
          tooltip-format = "Volume: {volume}%";
        };

        "group/backlight-modules" = {
          modules = [
            "backlight#icon"
            "backlight#percent"
          ];
          orientation = "inherit";
        };
        "backlight#icon" = {
          format = "{icon}";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 1%+ &> /dev/null";
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 1%- &> /dev/null";
          tooltip-format = "Backlight: {percent}%";
        };
        "backlight#percent" = {
          format = "{percent}%";
          tooltip-format = "Backlight: {percent}%";
        };

        "group/battery-modules" = {
          modules = [
            "battery#icon"
            "battery#capacity"
          ];
          orientation = "inherit";
        };
        "battery#icon" = {
          format = "{icon}";
          format-charging = "󱐋";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format-plugged = "󰚥";
          states = {
            warning = 30;
            critical = 15;
          };
          tooltip-format = "{timeTo}, {capacity}%";
        };
        "battery#capacity" = {
          format = "{capacity}%";
          tooltip-format = "{timeTo}, {capacity}%";
        };

        tray = {
          icon-size = 24;
          spacing = 10;
          show-passive-items = true;
        };

        clock = {
          actions = {
            on-scroll-down = "shift_down";
            on-scroll-up = "shift_up";
          };
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
          format = "{:%I:%M %p}";
          tooltip-format = "{calendar}";
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
        font-family: "GeistMono Nerd Font Propo", sans-serif;
        font-size: 11pt;
        font-weight: 500;
      }

      /* Menu */
      menu {
        background: ${xcolors.black0};
        border-radius: 12px;
      }

      menu separator {
        background: ${xcolors.black3};
      }

      menu menuitem {
        background: transparent;
        padding: 0.5rem;
        transition: 300ms linear;
      }

      menu menuitem:hover {
        background: lighter(${xcolors.black3});
      }

      menu menuitem:first-child {
        border-radius: 12px 12px 0 0;
      }

      menu menuitem:last-child {
        border-radius: 0 0 12px 12px;
      }

      menu menuitem:only-child {
        border-radius: 12px;
      }

      /* Tooltip */
      tooltip {
        background: ${xcolors.black0};
        border-radius: 12px;
      }

      tooltip label {
        margin: 0.5rem;
      }

      /* Waybar */
      window#waybar {
        background: ${xcolors.black0};
      }

      .modules-left {
        padding-left: 0.25rem;
      }

      .modules-right {
        padding-right: 0.25rem;
      }

      /* Modules */
      #workspaces,
      #workspaces button,
      #idle_inhibitor,
      #network-modules,
      #wireplumber-modules,
      #backlight-modules,
      #battery-modules,
      #tray,
      #clock,
      #custom-exit,
      #custom-lock,
      #custom-suspend,
      #custom-reboot,
      #custom-power {
        background: ${xcolors.black3};
        border-radius: 8px;
        margin: 0.5rem 0.25rem;
        transition: 300ms linear;
      }

      #image,
      #window,
      #network.address,
      #wireplumber.volume,
      #backlight.percent,
      #battery.capacity,
      #tray,
      #clock {
        padding: 0.25rem 0.75rem;
      }

      #idle_inhibitor,
      #network.icon,
      #wireplumber.icon,
      #backlight.icon,
      #battery.icon,
      #custom-exit,
      #custom-lock,
      #custom-suspend,
      #custom-reboot,
      #custom-power {
        background: ${xcolors.blue};
        color: ${xcolors.black3};
        border-radius: 8px;
        font-size: 13pt;
        padding: 0.25rem;
        min-width: 1.5rem;
        transition: 300ms linear;
      }

      /* Workspaces */
      #workspaces button {
        margin: 0;
        padding: 0.25rem;
        min-width: 1.5rem;
      }

      #workspaces button label {
        color: ${xcolors.white};
      }

      #workspaces button.empty label {
        color: ${xcolors.gray0};
      }

      #workspaces button.urgent label,
      #workspaces button.active label {
        color: ${xcolors.black3};
      }

      #workspaces button.urgent {
        background: ${xcolors.red};
      }

      #workspaces button.active {
        background: ${xcolors.blue};
      }

      /* Idle Inhibitor */
      #idle_inhibitor {
        background: ${xcolors.black3};
        color: ${xcolors.blue};
      }

      #idle_inhibitor.deactivated {
        color: ${xcolors.gray0};
      }

      /* Systray */
      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background: ${xcolors.red};
      }

      /* Hover effects */
      #workspaces button:hover,
      #idle_inhibitor:hover,
      #idle_inhibitor.deactivated:hover,
      #clock:hover {
        background: lighter(${xcolors.black3});
      }

      #workspaces button.urgent:hover {
        background: lighter(${xcolors.red});
      }

      #workspaces button.active:hover,
      #network.icon:hover,
      #wireplumber.icon:hover,
      #custom-exit:hover,
      #custom-lock:hover,
      #custom-suspend:hover,
      #custom-reboot:hover,
      #custom-power:hover {
        background: lighter(${xcolors.blue});
      }

      #workspaces button.urgent:hover label,
      #workspaces button.active:hover label,
      #network.icon:hover label,
      #wireplumber.icon:hover label,
      #custom-exit:hover label,
      #custom-lock:hover label,
      #custom-suspend:hover label,
      #custom-reboot:hover label,
      #custom-power:hover label {
        color: lighter(${xcolors.black3});
      }

      #workspaces button:hover label {
        color: lighter(${xcolors.white});
      }

      #workspaces button.empty:hover label {
        color: lighter(${xcolors.gray0});
      }

      #idle_inhibitor:hover {
        color: lighter(${xcolors.blue});
      }

      #idle_inhibitor.deactivated:hover {
        color: lighter(${xcolors.gray0});
      }
    '';
  };
}
