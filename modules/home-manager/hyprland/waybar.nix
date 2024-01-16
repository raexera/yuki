{
  lib,
  pkgs,
  themes,
  ...
}: let
  _ = lib.getExe;
  inherit (pkgs) brightnessctl pamixer;
  inherit (themes.colorscheme) xcolors;
in {
  programs.waybar = {
    enable = true;
    settings = let
      formatIcons = color: text: "<span font_size='larger' color='${color}'>${text}</span>";
    in [
      {
        layer = "top";
        position = "top";
        mode = "dock";
        exclusive = true;
        passthrough = false;
        fixed-center = true;
        gtk-layer-shell = true;
        spacing = 0;
        margin-top = 0;
        margin-right = 0;
        margin-bottom = 0;
        margin-left = 0;
        modules-left = [
          "custom/logo"
          "user"
          "hyprland/workspaces"
          "tray"
        ];
        modules-center = [];
        modules-right = [
          "network"
          "group/volume"
          "group/backlight-battery"
          "clock"
          "group/power"
        ];
        "custom/logo" = {
          format = " ";
          tooltip = false;
        };
        user = {
          format = "{user}";
          icon = false;
        };
        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
          disable-scroll = true;
          on-click = "activate";
          format = "{name}";
          persistent-workspaces = {
            "*" = 5;
          };
        };
        tray = {
          icon-size = 16;
          spacing = 8;
          show-passive-items = true;
        };
        network = {
          format-wifi = formatIcons "${xcolors.flamingo}" "󰖩" + " {essid}";
          format-ethernet = formatIcons "${xcolors.flamingo}" "󰈀" + " {ipaddr}/{cidr}";
          format-disconnected = formatIcons "${xcolors.red}" "󰖪";
          tooltip-format = ''
            󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}
            {ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)'';
        };
        "group/volume" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "pulseaudio-child";
            transition-left-to-right = false;
          };
          modules = [
            "pulseaudio"
            "pulseaudio/slider"
          ];
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };
        pulseaudio = {
          tooltip = false;
          format = formatIcons "${xcolors.mauve}" "{icon}" + " {volume}%";
          format-muted = formatIcons "${xcolors.red}" "󰖁";
          format-icons = {default = ["󰕿" "󰖀" "󰕾"];};
          on-click = "${_ pamixer} -t";
          on-scroll-up = "${_ pamixer} -d 1";
          on-scroll-down = "${_ pamixer} -i 1";
        };
        "group/backlight-battery" = {
          modules = [
            "backlight"
            "custom/separator"
            "battery"
          ];
          orientation = "inherit";
        };
        backlight = {
          tooltip = false;
          format = formatIcons "${xcolors.sky}" "{icon}" + " {percent}%";
          format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
          on-scroll-up = "${_ brightnessctl} -q s 1%-";
          on-scroll-down = "${_ brightnessctl} -q s +1%";
        };
        "custom/separator" = {
          format = formatIcons "${xcolors.gray1}" " | ";
          tooltip = false;
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          tooltip-format = "{timeTo}, {capacity}%";
          format = formatIcons "${xcolors.green}" "{icon}" + " {capacity}%";
          format-charging = formatIcons "${xcolors.green}" "󰂄" + " {capacity}%";
          format-plugged = formatIcons "${xcolors.green}" "󰚥" + " {capacity}%";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        clock = {
          format = formatIcons "${xcolors.peach}" "󱑎" + " {:%I:%M %p}";
          format-alt = formatIcons "${xcolors.yellow}" "󰃶" + " {:%a %d %b}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            on-scroll = 1;
            format = {
              months = "<span color='${xcolors.white}'><b>{}</b></span>";
              days = "<span color='${xcolors.gray1}'><b>{}</b></span>";
              weekdays = "<span color='${xcolors.blue}'><b>{}</b></span>";
              today = "<span color='${xcolors.white}'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        "group/power" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = false;
            children-class = "power-child";
          };
          modules = [
            "custom/power"
            "custom/quit"
            "custom/lock"
            "custom/suspend"
            "custom/reboot"
          ];
        };
        "custom/quit" = {
          format = formatIcons "${xcolors.teal}" "󰍃";
          on-click = "${pkgs.hyprland}/bin/hyprctl dispatch exit";
          tooltip = false;
        };
        "custom/lock" = {
          format = formatIcons "${xcolors.green}" "󰌾";
          on-click = "${pkgs.swaylock-effects}/bin/swaylock -S --daemonize";
          tooltip = false;
        };
        "custom/suspend" = {
          format = formatIcons "${xcolors.yellow}" "󰒲";
          on-click = "${pkgs.systemd}/bin/systemctl suspend";
          tooltip = false;
        };
        "custom/reboot" = {
          format = formatIcons "${xcolors.peach}" "󰜉";
          on-click = "${pkgs.systemd}/bin/systemctl reboot";
          tooltip = false;
        };
        "custom/power" = {
          format = formatIcons "${xcolors.red}" "󰐥";
          on-click = "${pkgs.systemd}/bin/systemctl poweroff";
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
        border: none;
        border-radius: 0;
        min-height: 0;
        min-width: 0;
        font-family: "Material Design Icons", Inter, sans-serif;
        font-size: 1rem;
      }

      window#waybar {
        background: ${xcolors.black0};
      }

      .modules-left {
        margin-left: 0.25rem;
      }

      .modules-right {
        margin-right: 0.25rem;
      }

      #backlight-battery,
      #clock,
      #custom-lock,
      #custom-logo,
      #custom-power,
      #custom-reboot,
      #custom-suspend,
      #custom-quit,
      #network,
      #pulseaudio,
      #pulseaudio-slider,
      #tray,
      #user {
        background: ${xcolors.black3};
        border-radius: 8px;
        min-width: 0.75rem;
        margin: 0.5rem 0.25rem;
        padding: 0.5rem 0.75rem;
      }

      #custom-logo {
        background-color: transparent;
        background-image: url("${snowflake}");
        background-position: center;
        background-repeat: no-repeat;
        background-size: 80%;
      }

      #user {
        color: ${xcolors.gray1};
        font-family: monospace, "monospace";
        font-weight: bold;
        letter-spacing: 0.25rem;
      }

      #workspaces {
        background: ${xcolors.black3};
        border-radius: 8px;
        margin: 0.5rem 0.25rem;
      }

      #workspaces button {
        border-radius: 8px;
        min-width: 0.75rem;
        padding: 0.5rem 0.75rem;
        transition: all 0.1s ease-in-out;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
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

      #workspaces button.active {
        background: ${xcolors.blue};
      }

      #workspaces button.active label {
        color: ${xcolors.black3};
        font-weight: bold;
      }

      #tray menuitem,
      #tray window {
        border-radius: 8px;
        padding: 0.5rem;
      }

      #tray menuitem:hover {
        background: ${xcolors.blue};
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      #pulseaudio-slider slider {
        min-height: 0px;
        min-width: 0px;
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
        margin: 0 0.625rem;
      }

      #pulseaudio-slider trough {
        min-height: 0.625rem;
        min-width: 5rem;
        border-radius: 8px;
        background: ${xcolors.black0};
      }

      #pulseaudio-slider highlight {
        min-width: 0.625rem;
        border-radius: 8px;
      }

      #pulseaudio-slider highlight {
        background: ${xcolors.mauve};
      }

      menu,
      tooltip {
        border-radius: 8px;
        padding: 0.5rem;
        background: ${xcolors.black0};
      }

      tooltip label {
        padding: 0.5rem;
      }
    '';

    systemd.enable = true;
    systemd.target = "graphical-session.target";
  };
}
