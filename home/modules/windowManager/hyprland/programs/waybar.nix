{
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs) brightnessctl pamixer;
  _ = lib.getExe;
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
        height = 40;
        spacing = 0;
        margin-top = 0;
        margin-right = 0;
        margin-bottom = 0;
        margin-left = 0;
        modules-left = [
          "custom/search"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [];
        modules-right = [
          "network"
          "pulseaudio"
          "pulseaudio#microphone"
          "backlight"
          "battery"
          "clock#date"
          "clock"
          "custom/power"
        ];
        "custom/search" = {
          format = " ";
          tooltip = false;
          on-click = "sh -c 'run-as-service $(wofi -S drun)'";
        };
        "hyprland/window" = {
          format = "{class}";
          separate-outputs = false;
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
          format-wifi = "󰖩 {essid}";
          format-ethernet = "󰈀 {ipaddr}/{cidr}";
          format-alt = "󱛇";
          format-disconnected = "󰖪";
          tooltip-format = ''
            󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}
            {ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)'';
        };
        pulseaudio = {
          tooltip = false;
          format = "{icon} {volume}%";
          format-muted = "󰖁";
          format-icons = {default = ["󰕿" "󰖀" "󰕾"];};
          tooltip-format = "{desc}, {volume}%";
          on-click = "${_ pamixer} -t";
          on-scroll-up = "${_ pamixer} -d 1";
          on-scroll-down = "${_ pamixer} -i 1";
        };
        "pulseaudio#microphone" = {
          tooltip = false;
          format = "{format_source}";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭";
          on-click = "${_ pamixer} --default-source -t";
          on-scroll-up = "${_ pamixer} --default-source -d 1";
          on-scroll-down = "${_ pamixer} --default-source -i 1";
        };
        backlight = {
          tooltip = false;
          format = "{icon} {percent}%";
          format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
          on-scroll-up = "${_ brightnessctl} -q s 1%-";
          on-scroll-down = "${_ brightnessctl} -q s +1%";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          tooltip-format = "{timeTo}, {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-alt = "{time} {icon}";
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
        };
        clock = {
          tooltip = false;
          format = "󱑎 {:%H:%M}";
        };
        "clock#date" = {
          format = "󰃶 {:%a %d %b}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        "custom/power" = {
          format = "󰐥";
          tooltip = false;
        };
      };
    };

    style = ''
      @define-color Background #000000;
      @define-color Foreground #ffffff;
      @define-color Accent #00FFFF;

      * {
        all: initial;
        border: none;
        border-radius: 0;
        min-height: 0;
        min-width: 0;
        font-family: "Material Design Icons", monospace;
        font-size: 11pt;
      }

      window#waybar {
        background-color: alpha(@Background, 0.2);
      }

      window#waybar.hidden {
        opacity: 0;
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

      #workspaces button label {
        color: alpha(@Foreground, 0.8);
      }

      #workspaces button.empty label {
        color: alpha(@Foreground, 0.4);
      }

      #workspaces button.urgent label {
        color: alpha(@Red, 0.8);
      }

      #workspaces button.special label {
        color: alpha(@Yellow, 0.8);
        text-shadow: 0 0 0.14em @Yellow, 0 0 0.27em @Yellow, 0 0 0.41em @Yellow,
          0 0 0.55em @Yellow, 0 0 0.68em @Yellow;
      }

      #workspaces button.active label {
        color: alpha(@Accent, 0.8);
        text-shadow: 0 0 0.14em @Accent, 0 0 0.27em @Accent, 0 0 0.41em @Accent,
          0 0 0.55em @Accent, 0 0 0.68em @Accent;
      }

      #backlight,
      #battery,
      #clock,
      #clock.date,
      #custom-power,
      #network,
      #pulseaudio,
      #pulseaudio.microphone,
      #tray,
      #window {
        color: alpha(@Foreground, 0.8);
        background-color: alpha(@Background, 0.2);
        border-radius: 4px;
        margin: 0.41em 0.21em;
        padding: 0.41em 0.82em;
      }

      #custom-power {
        margin-right: 0.41em;
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
  };
}
