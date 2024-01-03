{...}: let
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
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "battery"
          "clock"
          "custom/power"
        ];
        "custom/search" = {
          format = "";
          tooltip = false;
          on-click = "sh -c 'run-as-service $(wofi -S drun)'";
        };
        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
          disable-scroll = true;
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            active = "";
            default = "ﰓ";
            empty = "ﰓ";
          };
          persistent-workspaces = {
            "*" = 5;
          };
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "";
          format-plugged = "";
          tooltip-format = "{timeTo}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        clock = {
          format = "{:%H:%M}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#f5c2e7'><b>{}</b></span>";
              days = "<span color='#cdd6f4'><b>{}</b></span>";
              weeks = "<span color='#cba6f7'><b>T{:%U}</b></span>";
              weekdays = "<span color='#eba0ac'><b>{}</b></span>";
              today = "<span color='#a6e3a1'><b><u>{}</u></b></span>";
            };
            actions = {
              on-click-right = "mode";
              on-click-forward = "tz_up";
              on-click-backward = "tz_down";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
        };
        "custom/power" = {
          format = "";
          tooltip = false;
        };
      };
    };

    style = ''
      * {
        all: initial;
        font-family:'Dosis','Material Symbols Outlined';
      }

      #custom-search {
        background-image: url("${snowflake}");
        background-size: 65%;
        background-position: center;
        padding: 0 13px;
        background-repeat: no-repeat;
      }
    '';
  };
}
