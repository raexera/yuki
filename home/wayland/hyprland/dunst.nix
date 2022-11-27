{
  config,
  pkgs,
  ...
}: let
  theme = import ../../../theme/theme.nix {};
in {
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.catppuccin-folders;
      name = "Papirus";
    };
    settings = {
      global = {
        width = 220;
        height = 220;
        padding = 10;
        frame_width = 3;
        progress_bar_frame_width = 2;
        corner_radius = 12;
        transparency = 10;
        notification_limit = 3;
        idle_threshold = 120;
        history_length = 20;
        show_age_threshold = 60;
        max_icon_size = 64;
        separator_height = 1;
        alignment = "center";
        ellipsize = "middle";
        origin = "top-center";
        offset = "0x15";
        icon_position = "left";
        font = "JetBrainsMono Nerd Font 13";
        highlight = "#${theme.colors.mauve}";
        separator_color = "auto";
        ignore_newline = "no";
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
        markup = "yes";
        sticky_history = "yes";
        always_run_script = true;
        progress_bar = true;
        format = "<b>%a</b>\n%s";
        shrink = "no";
        word_wrap = "yes";
      };

      fullscreen_delay_everything = {fullscreen = "delay";};

      urgency_low = {
        background = "#${theme.colors.base}";
        foreground = "#${theme.colors.text}";
        frame_color = "#${theme.colors.mauve}";
        timeout = 5;
      };
      urgency_normal = {
        background = "#${theme.colors.base}";
        foreground = "#${theme.colors.text}";
        frame_color = "#${theme.colors.mauve}";
        timeout = 6;
      };
      urgency_critical = {
        background = "#${theme.colors.base}";
        foreground = "#${theme.colors.text}";
        frame_color = "#${theme.colors.red}";
        timeout = 0;
      };
    };
  };
}
