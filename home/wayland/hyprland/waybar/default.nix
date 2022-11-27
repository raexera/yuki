{
  pkgs,
  lib,
  config,
  ...
}: let
  theme = import ../../../../theme/theme.nix {};

  waybar-wttr = pkgs.stdenv.mkDerivation {
    name = "waybar-wttr";
    buildInputs = [
      (pkgs.python39.withPackages
        (pythonPackages: with pythonPackages; [requests]))
    ];
    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/bin
      cp ${./scripts/waybar-wttr.py} $out/bin/waybar-wttr
      chmod +x $out/bin/waybar-wttr
    '';
  };
in {
  xdg.configFile."waybar/style.css".text = import ./style.nix {inherit theme;};
  home.packages = [waybar-wttr];
  programs.waybar = {
    enable = true;
    # This version just works for my configuration
    # also this is not gentoo, I dont want to compile EVERYSINGLE WAYBAR UPDATE
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "Alexays";
        repo = "Waybar";
        rev = "cfef78a5bc8df6a29e06ec128f7a6075425db402";
        sha256 = "XMpl1soXKFe1NOux4HRBrmMrANgcnjGeGsUUKOzOFkE=";
      };
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      patchPhase = ''
        substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"hyprctl dispatch workspace \" + name_; system(command.c_str());"
      '';
    });
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mode = "dock";
        exclusive = true;
        passthrough = false;
        fixed-center = true;
        gtk-layer-shell = true;
        ipc = true;
        height = 34;
        spacing = 6;
        modules-left = [
          "custom/launcher"
          "wlr/workspaces"
          "custom/swallow"
          "custom/weather"
          "custom/todo"
          "tray"
        ];
        modules-center = [];
        modules-right = [
          "battery"
          "pulseaudio"
          "backlight"
          "network"
          "clock#date"
          "clock"
          "custom/power"
        ];
        "wlr/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          active-only = false;
          format-icons = {
            default = "󰊠";
            active = "󰮯";
          };
        };
        "custom/launcher" = {
          format = " ";
          tooltip = false;
          on-click = "killall rofi || rofi -show drun";
        };
        "custom/todo" = {
          format = "{}";
          tooltip = true;
          interval = 7;
          exec = "${./scripts/todo.sh}";
          return-type = "json";
        };
        "custom/weather" = {
          format = "{}";
          tooltip = true;
          interval = 20;
          exec = "waybar-wttr";
          return-type = "json";
        };
        "custom/swallow" = {
          tooltip = false;
          on-click = "${./scripts/waybar-swallow.sh}";
          format = "󰊰";
        };
        "custom/power" = {
          tooltip = false;
          on-click = "${./scripts/shutdown.sh} &";
          format = "󰤆";
        };
        tray = {
          spacing = 10;
        };
        clock = {
          format = "󱑎 {:%H:%M}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        "clock#date" = {
          format = "󰃶 {:%a %d %b}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          tooltip-format = "{timeTo}, {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥";
          format-alt = "{time} {icon}";
          format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        network = {
          format-wifi = "󰖩 {essid}";
          format-ethernet = "󰈀 {ipaddr}/{cidr}";
          format-alt = "󱛇";
          format-disconnected = "󰖪";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
        };
        pulseaudio = {
          scroll-step = 5;
          tooltip = false;
          format = "{icon} {volume}% {format_source}";
          format-muted = "󰖁 {format_source}";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭";
          format-icons = {default = ["󰕿" "󰖀" "󰕾"];};
          tooltip-format = "{desc}, {volume}%";
          on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
        };
      };
    };
  };
}
