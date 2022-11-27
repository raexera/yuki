{
  config,
  pkgs,
  ...
}: let
  theme = import ../../../theme/theme.nix {};
in {
  services.dunst = {
    enable = true;
    package = pkgs.fetchFromGitHub {
      owner = "k-vernooy";
      repo = "dunst";
      rev = "61567d58855ba872f8237861ddcd786d03dd2631";
      sha256 = "ttaaomjb3CclZG9JPdzDBj5XXlqRaKGPBY3ahFofqVM=";
    };
    iconTheme = {
      package = pkgs.catppuccin-folders;
      name = "Papirus";
    };
    settings = {
      global = {
        frame_color = "#${theme.colors.mauve}";
        separator_color = "#${theme.colors.blue}";
        width = 220;
        height = 220;
        offset = "0x15";
        font = "JetBrainsMono Nerd Font 16";
        corner_radius = 10;
        origin = "top-center";
        notification_limit = 3;
        idle_threshold = 120;
        ignore_newline = "no";
        mouse_left_click = "close_current";
        mouse_right_click = "close_all";
        sticky_history = "yes";
        history_length = 20;
        show_age_threshold = 60;
        ellipsize = "middle";
        padding = 10;
        always_run_script = true;
        frame_width = 3;
        transparency = 10;
        progress_bar = true;
        progress_bar_frame_width = 2;
        format = "<b>%a</b>\n%s";
        highlight = "#${theme.colors.mauve}";
      };
      urgency_low = {
        background = "#${theme.colors.base}";
        foreground = "#${theme.colors.text}";
        timeout = 5;
      };
      urgency_normal = {
        background = "#${theme.colors.base}";
        foreground = "#${theme.colors.text}";
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
