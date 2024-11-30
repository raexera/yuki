{config, ...}: {
  programs.kitty = {
    enable = true;
    settings = let
      inherit (config.theme.colorscheme) xcolors;
    in {
      # Fonts
      font_family = "GeistMono Nerd Font Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      disable_ligatures = "never";
      font_size = "12.0";

      # Cursor
      cursor_shape = "underline";
      cursor_underline_thickness = "1.5";
      cursor_blink_interval = "-1";
      cursor_stop_blinking_after = 0;

      # Scrollback
      scrollback_lines = 10000;
      touch_scroll_multiplier = "1.0";
      wheel_scroll_multiplier = "5.0";

      # Terminal bell
      enable_audio_bell = "no";
      visual_bell_duration = 0;
      window_alert_on_bell = "no";
      bell_on_tab = "no";
      command_on_bell = "none";

      # Window layout
      remember_window_size = "no";
      window_resize_step_cells = 1;
      window_resize_step_lines = 1;
      draw_minimal_borders = "yes";
      hide_window_decorations = "yes";
      inactive_text_alpha = "0.8";
      placement_strategy = "center";
      resize_in_steps = "no";
      window_margin_width = 0;
      window_padding_width = 15;
      confirm_os_window_close = 0;

      # Tab Bar
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
      tab_bar_edge = "bottom";
      tab_bar_min_tabs = 1;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

      # Color scheme
      background_opacity = "1.0";
      foreground = xcolors.white;
      background = xcolors.black2;
      selection_foreground = xcolors.black2;
      selection_background = xcolors.rosewater;

      # Cursor colors
      cursor = xcolors.rosewater;
      cursor_text_color = xcolors.black2;

      # URL underline color when hovering with mouse
      url_color = xcolors.rosewater;

      # Window border colors and terminal bell colors
      active_border_color = xcolors.blue;
      inactive_border_color = xcolors.gray0;
      bell_border_color = xcolors.yellow;
      visual_bell_color = "none";

      # Tab bar colors
      active_tab_foreground = xcolors.black1;
      active_tab_background = xcolors.blue;
      inactive_tab_foreground = xcolors.white;
      inactive_tab_background = xcolors.black2;
      tab_bar_background = xcolors.black1;

      # Colors for marks (marked text in the terminal)
      mark1_foreground = xcolors.black2;
      mark1_background = xcolors.lavender;
      mark2_foreground = xcolors.black2;
      mark2_background = xcolors.mauve;
      mark3_foreground = xcolors.black2;
      mark3_background = xcolors.sky;

      # The basic 16 colors
      # black
      color0 = xcolors.gray0;
      color8 = xcolors.gray1;

      # red
      color1 = xcolors.red;
      color9 = xcolors.red;

      # green
      color2 = xcolors.green;
      color10 = xcolors.green;

      # yellow
      color3 = xcolors.yellow;
      color11 = xcolors.yellow;

      # blue
      color4 = xcolors.blue;
      color12 = xcolors.blue;

      # magenta
      color5 = xcolors.pink;
      color13 = xcolors.pink;

      # cyan
      color6 = xcolors.sky;
      color14 = xcolors.sky;

      # white
      color7 = xcolors.white;
      color15 = xcolors.white;
    };

    keybindings = {
      # Clipboard
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";

      # Scrolling
      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+j" = "scroll_line_down";
      "ctrl+shift+page_up" = "scroll_page_up";
      "ctrl+shift+page_down" = "scroll_page_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+end" = "scroll_end";
      "ctrl+shift+h" = "show_scrollback";

      # Window management
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+n" = "new_os_window";
      "ctrl+shift+w" = "close_window";
      "ctrl+shift+]" = "next_window";
      "ctrl+shift+[" = "previous_window";
      "ctrl+shift+f" = "move_window_forward";
      "ctrl+shift+b" = "move_window_backward";
      "ctrl+shift+`" = "move_window_to_top";
      "ctrl+shift+r" = "start_resizing_window";
      "ctrl+shift+1" = "first_window";
      "ctrl+shift+2" = "second_window";
      "ctrl+shift+3" = "third_window";
      "ctrl+shift+4" = "fourth_window";
      "ctrl+shift+5" = "fifth_window";
      "ctrl+shift+6" = "sixth_window";
      "ctrl+shift+7" = "seventh_window";
      "ctrl+shift+8" = "eighth_window";
      "ctrl+shift+9" = "ninth_window";
      "ctrl+shift+0" = "tenth_window";

      # Tab management
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+q" = "close_tab";
      "ctrl+shift+." = "move_tab_forward";
      "ctrl+shift+," = "move_tab_backward";
      "ctrl+shift+alt+t" = "set_tab_title";

      # Layout management
      "ctrl+shift+l" = "next_layout";
      "ctrl+alt+t" = "goto_layout tall";
      "ctrl+alt+s" = "goto_layout stack";
      "ctrl+alt+p" = "last_used_layout";
      "ctrl+alt+z" = "toggle_layout stack";

      # Font sizes
      "ctrl+shift+equal" = "change_font_size all +1.0";
      "ctrl+shift+minus" = "change_font_size all -1.0";
      "ctrl+shift+backspace" = "change_font_size all 0";
    };
  };
}
