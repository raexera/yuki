{
  themes,
  inputs,
  pkgs,
  ...
}: let
  font_family = "Inter";
in {
  programs.hyprlock = {
    enable = true;

    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = true;
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
          outer_color = "rgba(255, 255, 255, 0.1)";
          inner_color = "rgba(0, 0, 0, 0.5)";
          font_color = "rgb(255, 255, 255)";
          fade_on_empty = false;
          placeholder_text = ''<span font_family="${font_family}">Password...</span>'';
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
          color = "rgb(255, 255, 255)";
          position = "0, 150";
          valign = "center";
          halign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          inherit font_family;
          font_size = 24;
          color = "rgb(255, 255, 255)";
          position = "0, 50";
          valign = "center";
          halign = "center";
        }
        {
          monitor = "";
          text = "$USER";
          inherit font_family;
          font_size = 18;
          color = "rgb(255, 255, 255)";
          position = "0, 50";
          valign = "bottom";
          halign = "center";
        }
      ];
    };
  };
}
