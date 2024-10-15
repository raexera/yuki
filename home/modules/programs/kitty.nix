{themes, ...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    settings = let
      inherit (themes.colorscheme) xcolors;
      inherit (themes.colorscheme.xcolors) normal bright;
    in {
      active_tab_font_style = "bold";
      background_opacity = "0.8";
      bold_font = "auto";
      bold_italic_font = "auto";
      confirm_os_window_close = 0;
      cursor_blink_interval = "-1";
      cursor_shape = "underline";
      cursor_stop_blinking_after = 0;
      cursor_underline_thickness = "1.5";
      disable_ligatures = "never";
      editor = "nvim";
      font_family = "JetBrains Mono";
      font_size = "11.0";
      hide_window_decorations = "titlebar-only";
      inactive_tab_font_style = "normal";
      inactive_text_alpha = "1.0";
      italic_font = "auto";
      placement_strategy = "center";
      resize_in_steps = "yes";
      scrollback_lines = 10000;
      tab_bar_edge = "bottom";
      tab_bar_min_tabs = 1;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      touch_scroll_multiplier = "1.0";
      wheel_scroll_multiplier = "5.0";
      window_margin_width = 0;
      window_padding_width = 15;

      # Basic colors
      foreground = xcolors.foreground;
      background = xcolors.background;
      selection_foreground = xcolors.foreground;
      selection_background = normal.blue;

      # Cursor colors
      cursor = xcolors.cursor;
      cursor_text_color = xcolors.cursor_text;

      # URL underline color when hovering with mouse
      url_color = normal.blue;

      # Window border colors and terminal bell colors
      active_border_color = normal.blue;
      inactive_border_color = bright.white;
      bell_border_color = normal.cyan;
      visual_bell_color = "none";

      # Tab bar colors
      active_tab_foreground = normal.black;
      active_tab_background = normal.cyan;
      inactive_tab_foreground = normal.white;
      inactive_tab_background = bright.white;
      tab_bar_background = normal.black;
      tab_bar_margin_color = "none";

      # Mark colors (marked text in the terminal)
      mark1_foreground = normal.black;
      mark1_background = normal.cyan;
      mark2_foreground = normal.black;
      mark2_background = normal.red;
      mark3_foreground = normal.black;
      mark3_background = normal.yellow;

      # The basic 16 colors
      # black
      color0 = normal.black;
      color8 = bright.white;

      # red
      color1 = normal.red;
      color9 = normal.red;

      # green
      color2 = normal.green;
      color10 = normal.green;

      # yellow
      color3 = normal.yellow;
      color11 = bright.yellow;

      # blue
      color4 = normal.blue;
      color12 = bright.blue;

      # magenta
      color5 = normal.magenta;
      color13 = normal.magenta;

      # cyan
      color6 = normal.cyan;
      color14 = bright.cyan;

      # white
      color7 = normal.white;
      color15 = bright.white;
    };

    keybindings = {
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";
      "ctrl+shift+c" = "copy_to_clipboard";
      "shift+insert" = "paste_from_selection";

      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+j" = "scroll_line_down";
      "ctrl+shift+page_up" = "scroll_page_up";
      "ctrl+shift+page_down" = "scroll_page_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+end" = "scroll_end";
      "ctrl+shift+h" = "show_scrollback";

      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+n" = "new_os_window";
      "ctrl+shift+w" = "close_window";
      "ctrl+shift+]" = "next_window";
      "ctrl+shift+[" = "previous_window";
      "ctrl+shift+f" = "move_window_forward";
      "ctrl+shift+b" = "move_window_backward";
      "ctrl+shift+`" = "move_window_to_top";
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

      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+q" = "close_tab";
      "ctrl+shift+l" = "next_layout";
      "ctrl+shift+." = "move_tab_forward";
      "ctrl+shift+," = "move_tab_backward";
      "ctrl+shift+alt+t" = "set_tab_title";

      "ctrl+shift+equal" = "increase_font_size";
      "ctrl+shift+minus" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
      "ctrl+shift+f6" = "set_font_size 16.0";
    };
  };
}
