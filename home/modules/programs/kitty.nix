{themes, ...}: {
  home.sessionVariables.TERMINAL = "kitty -1";

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    settings = let
      inherit (themes.colorscheme) xcolors;
    in {
      active_tab_font_style = "bold";
      background_opacity = "1.0";
      bold_font = "auto";
      bold_italic_font = "auto";
      confirm_os_window_close = 0;
      cursor_blink_interval = "-1";
      cursor_shape = "underline";
      cursor_stop_blinking_after = 0;
      cursor_underline_thickness = "1.5";
      disable_ligatures = "never";
      editor = "nvim";
      font_family = "Fira Code";
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

      # The basic colors
      foreground = xcolors.white;
      background = xcolors.black2;
      selection_foreground = xcolors.black2;
      selection_background = xcolors.rosewater;

      # Cursor colors
      cursor = xcolors.rosewater;
      cursor_text_color = xcolors.black2;

      # URL underline color
      url_color = xcolors.rosewater;

      # Tab bar colors
      tab_bar_background = xcolors.black1;
      active_tab_foreground = xcolors.black1;
      active_tab_background = xcolors.blue;
      inactive_tab_foreground = xcolors.white;
      inactive_tab_background = xcolors.black2;

      # The 16 terminal colors
      color0 = xcolors.gray0;
      color8 = xcolors.gray1;
      color1 = xcolors.red;
      color9 = xcolors.red;
      color2 = xcolors.green;
      color10 = xcolors.green;
      color3 = xcolors.yellow;
      color11 = xcolors.yellow;
      color4 = xcolors.blue;
      color12 = xcolors.blue;
      color5 = xcolors.pink;
      color13 = xcolors.pink;
      color6 = xcolors.sky;
      color14 = xcolors.sky;
      color7 = xcolors.white;
      color15 = xcolors.white;
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
