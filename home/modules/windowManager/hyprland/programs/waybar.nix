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
          "pulseaudio"
          "pulseaudio#microphone"
          "backlight"
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
          format = "󱑎 {:%I:%M %p}";
          format-alt = "󱑎 {:%H:%M}";
        };
        "clock#date" = {
          format = "󰃶 {:%a %d %b}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        "group/group-power" = {
          orientation = "inherit";
          drawer = {
            "transition-duration" = 500;
            "children-class" = "not-power";
            "transition-left-to-right" = false;
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
          format = "󰍃";
          tooltip = false;
        };
        "custom/lock" = {
          format = "󰌾";
          tooltip = false;
        };
        "custom/suspend" = {
          format = "󰒲";
          tooltip = false;
        };
        "custom/reboot" = {
          format = "󰜉";
          tooltip = false;
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
      @define-color Accent #88C0D0;
      @define-color Red #BF616A;
      @define-color Orange #D08770;
      @define-color Yellow #EBCB8B;
      @define-color Green #A3BE8C;
      @define-color Blue #81A1C1;
      @define-color Magenta #B48EAD;

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
        background-image: url("/nix/store/488hqs4jj4i981k6pfbbmxd62nigkpxa-Logo-14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8.svg");
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
        color: alpha(@Red, 0.8);
      }

      #workspaces button.special label {
        color: alpha(@Yellow, 0.8);
        text-shadow: 0 0 0.14em @Yellow, 0 0 0.27em @Yellow, 0 0 0.41em @Yellow,
          0 0 0.55em @Yellow, 0 0 0.68em @Yellow;
      }

      #user,
      #workspaces button.active label {
        color: alpha(@Accent, 0.8);
        text-shadow: 0 0 0.14em @Accent, 0 0 0.27em @Accent, 0 0 0.41em @Accent,
          0 0 0.55em @Accent, 0 0 0.68em @Accent;
      }

      #backlight,
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
      #pulseaudio.microphone,
      #tray,
      #user {
        color: alpha(@Foreground, 0.8);
        background-color: alpha(@Background, 0.2);
        border-radius: 4px;
        margin: 0.41em 0.21em;
        padding: 0.41em 0.82em;
      }

      #custom-quit {
        color: alpha(@Magenta, 0.8);
      }

      #custom-lock {
        color: alpha(@Green, 0.8);
      }

      #custom-suspend {
        color: alpha(@Blue, 0.8);
      }

      #custom-reboot {
        color: alpha(@Yellow, 0.8);
      }

      #custom-power {
        color: alpha(@Red, 0.8);
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
