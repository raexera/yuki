{
  config,
  lib,
  pkgs,
  ...
}: let
  volumectl = let
    inherit (pkgs) pamixer dunst libcanberra-gtk3;
    _ = lib.getExe;
  in
    pkgs.writeShellScriptBin "volumectl" ''
      #!/usr/bin/env sh

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

      volume="$(${_ pamixer} --get-volume)"
      isMuted="$(${_ pamixer} --get-mute)"

      if [ "$isMuted" = "true" ]; then
          ${dunst}/bin/dunstify -r 2593 \
              -u normal \
              -a "VOLUMECTL" "Muted" \
              -i audio-volume-muted-symbolic
      else
          ${dunst}/bin/dunstify -r 2593 \
              -u normal \
              -a "VOLUMECTL" "Volume: " \
              -h int:value:"$volume" \
              -i audio-volume-high-symbolic

          ${libcanberra-gtk3}/bin/canberra-gtk-play -i audio-volume-change -d "volumectl"
      fi
    '';

  lightctl = let
    inherit (pkgs) brightnessctl dunst;
    _ = lib.getExe;
  in
    pkgs.writeShellScriptBin "lightctl" ''
      #!/usr/bin/env sh

      case "$1" in
      up)
          ${_ brightnessctl} -q s +"$2"%
          ;;
      down)
          ${_ brightnessctl} -q s "$2"%-
          ;;
      esac

      brightness_percentage=$((($(${_ brightnessctl} g) * 100) / $(${_ brightnessctl} m)))
      ${dunst}/bin/dunstify -r 2593 \
          -u normal \
          -a "LIGHTCTL" "Brightness: " \
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
    settings = {
      global = {
        alignment = "left";
        corner_radius = 12;
        ellipsize = "middle";
        enable_recursive_icon_lookup = true;
        follow = "mouse";
        font = "Dosis 11";
        format = "<b>%a</b>\\n<i>%s</i>%p\\n%b";
        frame_width = 0;
        gap_size = 5;
        height = 300;
        horizontal_padding = 12;
        icon_corner_radius = 0;
        icon_position = "left";
        icon_theme = "Adwaita";
        ignore_newline = false;
        indicate_hidden = true;
        layer = "top";
        line_height = 0;
        markup = "full";
        max_icon_size = 64;
        min_icon_size = 64;
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
        notification_limit = 20;
        offset = "5x5";
        origin = "top_center";
        padding = 8;
        progress_bar = true;
        progress_bar_corner_radius = 12;
        progress_bar_frame_width = 0;
        progress_bar_height = 10;
        progress_bar_max_width = 300;
        progress_bar_min_width = 150;
        scale = 0;
        separator_color = "auto";
        separator_height = 2;
        show_indicators = true;
        sort = true;
        text_icon_padding = 0;
        vertical_alignment = "center";
        width = 300;
        word_wrap = true;
      };

      fullscreen_delay_everything.fullscreen = "delay";

      urgency_low = {
        background = "#00000033";
        foreground = "#D8DEE9B2";
        highlight = "#88C0D0B2";
        timeout = 2;
      };

      urgency_normal = {
        background = "#00000033";
        foreground = "#D8DEE9B2";
        highlight = "#88C0D0B2";
        timeout = 2;
      };

      urgency_critical = {
        background = "#FF000033";
        foreground = "#D8DEE9B2";
        highlight = "#88C0D0B2";
        timeout = 10;
      };
    };
  };
}
