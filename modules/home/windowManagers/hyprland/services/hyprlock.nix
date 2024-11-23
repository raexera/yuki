{config, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = let
      inherit (config.theme.colorscheme) colors;
    in {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 2;
          blur_size = 2;
          new_optimizations = true;
          ignore_opacity = false;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 2;
          outer_color = "rgb(${colors.gray0})";
          inner_color = "rgb(${colors.black0})";
          font_color = "rgb(${colors.white})";
          check_color = "rgb(${colors.blue})";
          fail_color = "rgb(${colors.red})";
          fade_on_empty = false;
          placeholder_text = "<i>Enter Password</i>";
          dots_spacing = 0.2;
          dots_center = true;
          position = "0, 125";
          valign = "bottom";
          halign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%A, %B %d'";
          font_family = "JetBrainsMono Nerd Font Propo Bold";
          font_size = 36;
          color = "rgb(${colors.white})";
          position = "0, -150";
          valign = "top";
          halign = "center";
        }
        {
          monitor = "";
          text = "$TIME";
          font_family = "JetBrainsMono Nerd Font Propo Bold";
          font_size = 132;
          color = "rgb(${colors.white})";
          position = "0, -200";
          valign = "top";
          halign = "center";
        }
        {
          monitor = "";
          text = "   $USER";
          font_family = "JetBrainsMono Nerd Font Propo Bold";
          font_size = 24;
          color = "rgb(${colors.white})";
          position = "0, 200";
          valign = "bottom";
          halign = "center";
        }
      ];
    };
  };
}
