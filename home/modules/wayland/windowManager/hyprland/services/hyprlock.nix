{
  themes,
  inputs,
  pkgs,
  ...
}: let
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
          placeholder_text = "<i>Input Password...</i>";
          dots_spacing = 0.2;
          dots_center = true;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_family = "Inter Display Bold";
          font_size = 120;
          color = "rgb(${colors.white})";
          position = "0, 240";
          valign = "center";
          halign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          font_family = "Inter Display";
          font_size = 24;
          color = "rgb(${colors.white})";
          position = "0, 120";
          valign = "center";
          halign = "center";
        }
        {
          monitor = "";
          text = "   $USER";
          font_family = "Inter Display Medium";
          font_size = 18;
          color = "rgb(${colors.white})";
          position = "0, 48";
          valign = "bottom";
          halign = "center";
        }
      ];
    };
  };
}
