{
  programs.alacritty = {
    enable = true;

    settings = {
      env = {
        TERM = "xterm-256color";
      };

      window = {
        padding = {
          x = 20;
          y = 20;
        };

        dynamic_padding = true;
        dynamic_title = false;
        decorations_theme_variant = "Dark";
        opacity = 1.0;
      };

      font = {
        size = 11;
        builtin_box_drawing = true;
      };

      cursor.style = {
        shape = "Beam";
        blinking = "On";
      };

      draw_bold_text_with_bright_colors = true;

      colors = {
        primary = {
          background = "#24273A";
          foreground = "#CAD3F5";
          dim_foreground = "#CAD3F5";
          bright_foreground = "#CAD3F5";
        };

        cursor = {
          text = "#24273A";
          cursor = "#F4DBD6";
        };

        vi_mode_cursor = {
          text = "#24273A";
          cursor = "#B7BDF8";
        };

        search = {
          matches = {
            foreground = "#24273A";
            background = "#A5ADCB";
          };

          focused_match = {
            foreground = "#24273A";
            background = "#A6DA95";
          };

          footer_bar = {
            foreground = "#24273A";
            background = "#A5ADCB";
          };
        };

        hints = {
          start = {
            foreground = "#24273A";
            background = "#EED49F";
          };

          end = {
            foreground = "#24273A";
            background = "#A5ADCB";
          };
        };

        selection = {
          text = "#24273A";
          background = "#F4DBD6";
        };

        normal = {
          black = "#494D64";
          red = "#ED8796";
          green = "#A6DA95";
          yellow = "#EED49F";
          blue = "#8AADF4";
          magenta = "#F5BDE6";
          cyan = "#8BD5CA";
          white = "#B8C0E0";
        };

        bright = {
          black = "#5B6078";
          red = "#ED8796";
          green = "#A6DA95";
          yellow = "#EED49F";
          blue = "#8AADF4";
          magenta = "#F5BDE6";
          cyan = "#8BD5CA";
          white = "#A5ADCB";
        };

        dim = {
          black = "#494D64";
          red = "#ED8796";
          green = "#A6DA95";
          yellow = "#EED49F";
          blue = "#8AADF4";
          magenta = "#F5BDE6";
          cyan = "#8BD5CA";
          white = "#B8C0E0";
        };

        indexed_colors = [
          {
            index = 16;
            color = "#F5A97F";
          }
          {
            index = 17;
            color = "#F4DBD6";
          }
        ];
      };
    };
  };
}
