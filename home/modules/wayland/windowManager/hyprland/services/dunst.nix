{
  config,
  themes,
  ...
}: {
  services.dunst = {
    enable = true;
    inherit (config.gtk) iconTheme;

    settings = let
      inherit (themes.colorscheme) xcolors;
    in {
      global = {
        alignment = "left";
        corner_radius = 12;
        ellipsize = "middle";
        enable_recursive_icon_lookup = true;
        follow = "mouse";
        font = "Inter 11";
        format = "<b>%a</b>\\n<i>%s</i>\\n%b";
        frame_color = "${xcolors.gray0}";
        frame_width = 2;
        gap_size = 5;
        hide_duplicate_count = false;
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
        stack_duplicates = true;
        text_icon_padding = 12;
        vertical_alignment = "center";
        width = 300;
        word_wrap = true;
      };

      fullscreen_delay_everything.fullscreen = "delay";

      urgency_low = {
        background = "${xcolors.black0}";
        foreground = "${xcolors.white}";
        highlight = "${xcolors.blue}";
        frame_color = "${xcolors.gray0}";
        timeout = 2;
      };

      urgency_normal = {
        background = "${xcolors.black0}";
        foreground = "${xcolors.white}";
        highlight = "${xcolors.blue}";
        frame_color = "${xcolors.gray0}";
        timeout = 2;
      };

      urgency_critical = {
        background = "${xcolors.black0}";
        foreground = "${xcolors.white}";
        highlight = "${xcolors.blue}";
        frame_color = "${xcolors.red}";
        timeout = 10;
      };
    };
  };
}
