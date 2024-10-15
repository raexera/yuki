{
  config,
  lib,
  pkgs,
  themes,
  ...
}: let
  _ = lib.getExe;

  # Volume control utility
  volumectl = let
    inherit (pkgs) libnotify pamixer libcanberra-gtk3;
  in
    pkgs.writeShellScriptBin "volumectl" ''
      #!/usr/bin/env bash

      case "$1" in
      up)
        ${_ pamixer} -i "$2"
        ;;
      down)
        ${_ pamixer} -d "$2"
        ;;
      toggle-mute)
        ${_ pamixer} -t
        ;;
      esac

      volume_percentage="$(${_ pamixer} --get-volume)"
      isMuted="$(${_ pamixer} --get-mute)"

      if [ "$isMuted" = "true" ]; then
        ${libnotify}/bin/notify-send -u normal -a "VOLUMECTL" "Volume Muted" -i audio-volume-muted-symbolic
      else
        ${libnotify}/bin/notify-send -u normal -a "VOLUMECTL" "Volume: $volume_percentage%" \
          -h string:x-canonical-private-synchronous:volumectl \
          -h int:value:"$volume_percentage" \
          -i audio-volume-high-symbolic

        ${libcanberra-gtk3}/bin/canberra-gtk-play -i audio-volume-change -d "volumectl"
      fi
    '';

  # Brightness control utility
  lightctl = let
    inherit (pkgs) libnotify brightnessctl;
  in
    pkgs.writeShellScriptBin "lightctl" ''
      case "$1" in
      up)
        ${_ brightnessctl} -q s +"$2"%
        ;;
      down)
        ${_ brightnessctl} -q s "$2"%-
        ;;
      esac

      brightness_percentage=$((($(${_ brightnessctl} g) * 100) / $(${_ brightnessctl} m)))
      ${libnotify}/bin/notify-send -u normal -a "LIGHTCTL" "Brightness: $brightness_percentage%"  \
        -h string:x-canonical-private-synchronous:lightctl \
        -h int:value:"$brightness_percentage" \
        -i display-brightness-symbolic
    '';
in {
  home.packages = [
    volumectl
    lightctl
  ];

  services.dunst = {
    enable = true;
    inherit (config.gtk) iconTheme;
    settings = let
      inherit (themes.colorscheme) xcolors;
      inherit (themes.colorscheme.xcolors) normal bright;
    in {
      global = {
        alignment = "left";
        corner_radius = 12;
        ellipsize = "middle";
        enable_recursive_icon_lookup = true;
        follow = "mouse";
        font = "Inter 11";
        format = "<b>%a</b>\\n<i>%s</i>\\n%b";
        frame_color = "${bright.black}";
        frame_width = 2;
        gap_size = 5;
        horizontal_padding = 12;
        icon_corner_radius = 0;
        icon_position = "left";
        icon_theme = "Papirus-Dark";
        ignore_newline = false;
        indicate_hidden = true;
        layer = "top";
        line_height = 0;
        markup = "full";
        max_icon_size = 64;
        min_icon_size = 48;
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
        notification_limit = 20;
        offset = "5x5";
        origin = "top-center";
        padding = 12;
        progress_bar = true;
        progress_bar_corner_radius = 12;
        progress_bar_frame_width = 0;
        progress_bar_height = 12;
        progress_bar_max_width = 300;
        progress_bar_min_width = 150;
        separator_color = "auto";
        separator_height = 2;
        show_indicators = true;
        sort = true;
        text_icon_padding = 12;
        vertical_alignment = "center";
        width = 300;
        word_wrap = true;
      };

      fullscreen_delay_everything.fullscreen = "delay";

      urgency_low = {
        background = "${xcolors.background_dark}";
        foreground = "${xcolors.foreground}";
        highlight = "${normal.blue}";
        frame_color = "${bright.black}";
        timeout = 2;
      };

      urgency_normal = {
        background = "${xcolors.background_dark}";
        foreground = "${xcolors.foreground}";
        highlight = "${normal.blue}";
        frame_color = "${bright.black}";
        timeout = 2;
      };

      urgency_critical = {
        background = "${xcolors.background_dark}";
        foreground = "${xcolors.foreground}";
        highlight = "${normal.blue}";
        frame_color = "${bright.red}";
        timeout = 10;
      };
    };
  };
}
