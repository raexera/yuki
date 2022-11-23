{
  config,
  lib,
  pkgs,
  ...
}: let
  theme = import ../../theme/theme.nix {};
in {
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "1.0";
      font_family = "monospace";
      font_size = 14;
      disable_ligatures = "never";
      cursor_shape = "underline";
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "15.0";
      scrollback_lines = 10000;
      click_interval = "0.5";
      select_by_word_characters = ":@-./_~?&=%+#";
      remember_window_size = false;
      allow_remote_control = true;
      initial_window_width = 640;
      initial_window_height = 400;
      repaint_delay = 15;
      input_delay = 3;
      visual_bell_duration = "0.0";
      url_style = "double";
      open_url_with = "default";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      window_padding_width = 15;
      window_margin_width = 10;

      # The basic colors
      foreground = "#${theme.colors.text}";
      background = "#${theme.colors.base}";
      selection_foreground = "#${theme.colors.base}";
      selection_background = "#${theme.colors.rosewater}";

      # Cursor colors
      cursor = "#${theme.colors.rosewater}";
      cursor_text_color = "#${theme.colors.base}";

      # URL underline color when hovering with mouse
      url_color = "#${theme.colors.rosewater}";

      # Kitty window border colors
      active_border_color = "#${theme.colors.lavender}";
      inactive_border_color = "#${theme.colors.overlay0}";
      bell_border_color = "#${theme.colors.yellow}";

      # Tab bar colors
      active_tab_foreground = "#${theme.colors.crust}";
      active_tab_background = "#${theme.colors.pink}";
      inactive_tab_foreground = "#${theme.colors.text}";
      inactive_tab_background = "#${theme.colors.mantle}";
      tab_bar_background = "#${theme.colors.crust}";

      # Colors for marks (marked text in the terminal)
      mark1_foreground = "#${theme.colors.base}";
      mark1_background = "#${theme.colors.lavender}";
      mark2_foreground = "#${theme.colors.base}";
      mark2_background = "#${theme.colors.pink}";
      mark3_foreground = "#${theme.colors.base}";
      mark3_background = "#${theme.colors.sapphire}";

      # The 16 terminal colors

      # black
      color0 = "#${theme.colors.surface1}";
      color8 = "#${theme.colors.surface2}";

      # red
      color1 = "#${theme.colors.red}";
      color9 = "#${theme.colors.red}";

      # green
      color2 = "#${theme.colors.green}";
      color10 = "#${theme.colors.green}";

      # yellow
      color3 = "#${theme.colors.yellow}";
      color11 = "#${theme.colors.yellow}";

      # blue
      color4 = "#${theme.colors.blue}";
      color12 = "#${theme.colors.blue}";

      # magenta
      color5 = "#${theme.colors.mauve}";
      color13 = "#${theme.colors.mauve}";

      # cyan
      color6 = "#${theme.colors.teal}";
      color14 = "#${theme.colors.teal}";

      # white
      color7 = "#${theme.colors.subtext1}";
      color15 = "#${theme.colors.subtext0}";
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+alt+c" = "copy_to_clipboard";
      "ctrl+alt+v" = "paste_from_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";

      "ctrl+shift+up" = "increase_font_size";
      "ctrl+shift+down" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";

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
    };
  };
}
