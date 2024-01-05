{
  lib,
  pkgs,
  ...
}: let
  _ = lib.getExe;
  inherit (pkgs) brightnessctl pamixer;

  formatIcons = color: text: "<span color='${color}' font_size='13pt'>${text}</span>";

  snowflake = builtins.fetchurl rec {
    name = "Logo-${sha256}.svg";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
    sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
  };
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
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
          "custom/search"
          "user"
          "hyprland/workspaces"
        ];
        modules-center = [];
        modules-right = [
          "network"
          "pulseaudio#microphone"
          "group/group-pulseaudio"
          "group/group-backlight"
          "battery"
          "clock#date"
          "clock"
          "group/group-power"
        ];
        "custom/search" = {
          format = " ";
          tooltip = false;
          on-click = "sh -c 'run-as-service $(wofi -S drun)'";
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
        network = {
          format-wifi = formatIcons "#88C0D0CC" "󰖩" + " {essid}";
          format-ethernet = formatIcons "#88C0D0CC" "󰈀" + " {ipaddr}/{cidr}";
          format-disconnected = formatIcons "#BF616ACC" "󰖪";
          tooltip-format = ''
            󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}
            {ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)'';
        };
        "group/group-pulseaudio" = {
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
          format = formatIcons "#88C0D0CC" "{icon}" + " {volume}%";
          format-muted = formatIcons "#BF616ACC" "󰖁";
          format-icons = {default = ["󰕿" "󰖀" "󰕾"];};
          on-click = "${_ pamixer} -t";
          on-scroll-up = "${_ pamixer} -d 1";
          on-scroll-down = "${_ pamixer} -i 1";
        };
        "pulseaudio#microphone" = {
          tooltip = false;
          format = "{format_source}";
          format-source = formatIcons "#88C0D0CC" "󰍬" + " {volume}%";
          format-source-muted = formatIcons "#BF616ACC" "󰍭";
          on-click = "${_ pamixer} --default-source -t";
          on-scroll-up = "${_ pamixer} --default-source -d 1";
          on-scroll-down = "${_ pamixer} --default-source -i 1";
        };
        "group/group-backlight" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "backlight-child";
            transition-left-to-right = false;
          };
          modules = [
            "backlight"
            "backlight/slider"
          ];
        };
        "backlight/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };
        backlight = {
          tooltip = false;
          format = formatIcons "#88C0D0CC" "{icon}" + " {percent}%";
          format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
          on-scroll-up = "${_ brightnessctl} -q s 1%-";
          on-scroll-down = "${_ brightnessctl} -q s +1%";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          tooltip-format = "{timeTo}, {capacity}%";
          format = formatIcons "#88C0D0CC" "{icon}" + " {capacity}%";
          format-charging = formatIcons "#A3BE8CCC" "󰂄" + " {capacity}%";
          format-plugged = formatIcons "#A3BE8CCC" "󰚥" + " {capacity}%";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        clock = {
          format = formatIcons "#88C0D0CC" "󱑎" + " {:%I:%M %p}";
          format-alt = formatIcons "#88C0D0CC" "󱑎" + " {:%H:%M}";
        };
        "clock#date" = {
          format = formatIcons "#88C0D0CC" "󰃶" + " {:%a %d %b}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        "group/group-power" = {
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
          format = formatIcons "#B48EADCC" "󰍃";
          onclick = "loginctl terminate-user $USER";
          tooltip = false;
        };
        "custom/lock" = {
          format = formatIcons "#81A1C1CC" "󰌾";
          onclick = "loginctl lock-session";
          tooltip = false;
        };
        "custom/suspend" = {
          format = formatIcons "#A3BE8CCC" "󰒲";
          onclick = "systemctl suspend";
          tooltip = false;
        };
        "custom/reboot" = {
          format = formatIcons "#EBCB8BCC" "󰜉";
          on-click = "systemctl reboot";
          tooltip = false;
        };
        "custom/power" = {
          format = formatIcons "#BF616ACC" "󰐥";
          on-click = "systemctl poweroff";
          tooltip = false;
        };
      };
    };

    style = ''
      @define-color Background #000000;
      @define-color Foreground #ffffff;
      @define-color Accent #88C0D0;
      @define-color Error #BF616A;
      @define-color Warning #EBCB8B;

      * {
        all: initial;
        border: none;
        border-radius: 0;
        min-height: 0;
        min-width: 0;
        font-family: "Material Design Icons", monospace;
        font-size: 1rem;
      }

      window#waybar {
        background-color: alpha(@Background, 0.2);
      }

      #custom-search {
        margin: 0 0.41em;
        padding: 0.41em 0.82em;
        background-image: url("${snowflake}");
        background-size: 80%;
        background-position: center;
        background-repeat: no-repeat;
      }

      #workspaces {
        background-color: alpha(@Background, 0.2);
        border-radius: 4px;
        margin: 0.41em 0.21em;
        padding: 0.41em 0.82em;
      }

      #workspaces button {
        margin: 0 0.82em;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
      }

      #workspaces button label {
        color: alpha(@Foreground, 0.8);
      }

      #workspaces button.empty label {
        color: alpha(@Foreground, 0.4);
      }

      #workspaces button.urgent label {
        color: alpha(@Error, 0.8);
      }

      #workspaces button.special label {
        color: alpha(@Warning, 0.8);
        text-shadow:
          0 0 0.14em @Warning,
          0 0 0.27em @Warning,
          0 0 0.41em @Warning,
          0 0 0.55em @Warning,
          0 0 0.68em @Warning;
      }

      #user,
      #workspaces button.active label {
        color: alpha(@Accent, 0.8);
        text-shadow:
          0 0 0.14em @Accent,
          0 0 0.27em @Accent,
          0 0 0.41em @Accent,
          0 0 0.55em @Accent,
          0 0 0.68em @Accent;
      }

      #backlight,
      #backlight-slider,
      #battery,
      #clock,
      #clock.date,
      #custom-lock,
      #custom-power,
      #custom-reboot,
      #custom-suspend,
      #custom-quit,
      #network,
      #pulseaudio,
      #pulseaudio-slider,
      #pulseaudio.microphone,
      #tray,
      #user {
        color: alpha(@Foreground, 0.8);
        background-color: alpha(@Background, 0.2);
        border-radius: 4px;
        margin: 0.41em 0.21em;
        padding: 0.41em 0.82em;
      }

      #backlight-slider slider,
      #pulseaudio-slider slider {
        min-height: 0px;
        min-width: 0px;
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
        margin: 0 0.68em;
      }

      #backlight-slider trough,
      #pulseaudio-slider trough {
        min-height: 0.68em;
        min-width: 5.47em;
        border-radius: 8px;
        background-color: alpha(@Background, 0.2);
      }

      #backlight-slider highlight,
      #pulseaudio-slider highlight {
        min-width: 0.68em;
        border-radius: 8px;
        background-color: alpha(@Accent, 0.8);
        box-shadow:
          0 0 0.14em @Accent,
          0 0 0.27em @Accent,
          0 0 0.41em @Accent,
          0 0 0.55em @Accent;
      }

      tooltip {
        color: alpha(@Foreground, 0.8);
        background-color: alpha(@Background, 0.2);
        font-family: "Dosis", sans-serif;
        border-radius: 8px;
        padding: 1.37em;
        margin: 2.05em;
      }

      tooltip label {
        font-family: "Dosis", sans-serif;
        padding: 1.37em;
      }
    '';

    systemd.enable = true;
    systemd.target = "graphical-session.target";
  };
}
