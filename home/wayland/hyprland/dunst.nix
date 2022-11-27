{
  config,
  pkgs,
  theme,
  ...
}: {
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.catppuccin-folders;
      name = "Papirus";
    };
    settings = {
      global = {
        follow = "mouse";
        width = 220;
        height = 220;
        padding = 10;
        horizontal_padding = 10;
        text_icon_padding = 0;
        frame_width = 3;
        progress_bar_frame_width = 2;
        corner_radius = 12;
        transparency = 0;
        gap_size = 0;
        line_height = 0;
        separator_height = 2;
        notification_limit = 3;
        idle_threshold = 120;
        history_length = 20;
        show_age_threshold = 60;
        max_icon_size = 64;
        format = "<b>%a</b>\n%s";
        alignment = "center";
        vertical_alignment = "top";
        ellipsize = "middle";
        origin = "top-center";
        offset = "15x15";
        icon_position = "left";
        font = "JetBrainsMono Nerd Font 11";
        highlight = theme.xcolors.mauve;
        frame_color = theme.xcolors.mauve;
        separator_color = "frame";
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
        markup = "full";
        sort = "yes";
        sticky_history = "yes";
        word_wrap = "yes";
        indicate_hidden = "yes";
        ignore_newline = "no";
        show_indicators = "no";
        shrink = "no";
        stack_duplicates = true;
        always_run_script = true;
        progress_bar = true;
        hide_duplicate_count = false;
      };

      fullscreen_delay_everything = {fullscreen = "delay";};

      urgency_low = {
        background = theme.xcolors.base;
        foreground = theme.xcolors.text;
        timeout = 5;
      };
      urgency_normal = {
        background = theme.xcolors.base;
        foreground = theme.xcolors.text;
        timeout = 6;
      };
      urgency_critical = {
        background = theme.xcolors.base;
        foreground = theme.xcolors.red;
        frame_color = theme.xcolors.red;
        timeout = 0;
      };
    };
  };
}
