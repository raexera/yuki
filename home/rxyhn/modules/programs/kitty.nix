{
  config,
  pkgs,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "1.0";
      font_family = "Liga SFMono Nerd Font";
      font_size = 13;
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
      foreground = "#${colors.base05}";
      background = "#${colors.base00}";
      selection_background = "#${colors.base05}";
      selection_foreground = "#${colors.base00}";

      # Cursor colors
      cursor = "#${colors.base04}";
      cursor_text_color = "#${colors.base00}";

      # URL underline color when hovering with mouse
      url_color = "#${colors.base04}";

      # Kitty window border colors
      active_border_color = "#${colors.base03}";
      inactive_border_color = "#${colors.base01}";

      # Tab bar colors
      active_tab_background = "#${colors.base00}";
      active_tab_foreground = "#${colors.base06}";
      inactive_tab_background = "#${colors.base01}";
      inactive_tab_foreground = "#${colors.base04}";
      tab_bar_background = "#${colors.base01}";

      # Base16 colors
      # Normal
      color0 = "#${colors.base00}";
      color1 = "#${colors.base0B}";
      color2 = "#${colors.base0C}";
      color3 = "#${colors.base0D}";
      color4 = "#${colors.base07}";
      color5 = "#${colors.base0F}";
      color6 = "#${colors.base09}";
      color7 = "#${colors.base04}";

      # Bright
      color8 = "#${colors.base03}";
      color9 = "#${colors.base0B}";
      color10 = "#${colors.base0C}";
      color11 = "#${colors.base0D}";
      color12 = "#${colors.base07}";
      color13 = "#${colors.base0F}";
      color14 = "#${colors.base09}";
      color15 = "#${colors.base06}";
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
