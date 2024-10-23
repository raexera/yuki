{
  themes,
  inputs,
  pkgs,
  ...
}: let
  font_family = "Inter";
  inherit (themes.colorscheme) colors;
in {
  programs.hyprlock = {
    enable = true;

    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = [
        {
          monitor = "";
          path = themes.wallpaper;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 1;
          outer_color = "rgb(${colors.background_dark})";
          inner_color = "rgb(${colors.background})";
          font_color = "rgb(${colors.foreground})";
          check_color = "rgb(${colors.accent})";
          fail_color = "rgb(${colors.normal.red})";
          placeholder_text = ''<span font_family="${font_family}"><i>Input Password...</i></span>'';
          dots_spacing = 0.2;
          dots_center = true;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          inherit font_family;
          font_size = 96;
          color = "rgb(${colors.foreground})";
          position = "0, 150";
          valign = "center";
          halign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          inherit font_family;
          font_size = 24;
          color = "rgb(${colors.foreground})";
          position = "0, 50";
          valign = "center";
          halign = "center";
        }
        {
          monitor = "";
          text = "$USER";
          inherit font_family;
          font_size = 18;
          color = "rgb(${colors.foreground})";
          position = "0, 50";
          valign = "bottom";
          halign = "center";
        }
      ];
    };
  };
}
