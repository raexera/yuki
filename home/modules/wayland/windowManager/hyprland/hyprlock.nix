{inputs, ...}: {
  imports = [
    inputs.hyprlock.homeManagerModules.hyprlock
  ];

  programs.hyprlock = {
    enable = true;

    general = {
      disable_loading_bar = false;
      hide_cursor = true;
    };

    backgrounds = [
      {color = "rgba(0, 0, 0, 0.5)";}
    ];

    input-fields = [
      {
        size = {
          width = 200;
          height = 50;
        };
        outline_thickness = 3;
        dots_size = 0.33;
        dots_spacing = 0.15;
        outer_color = "rgba(255, 255, 255, 0.1)";
        inner_color = "rgba(255, 255, 255, 0.1)";
        font_color = "rgb(255, 255, 255)";
        fade_on_empty = true;
        placeholder_text = "<i>Input Password...</i>";
        hide_input = false;
        position = {
          x = 0;
          y = -30;
        };
        halign = "center";
        valign = "center";
      }
    ];

    labels = [
      {
        text = "<b>$TIME</b>";
        color = "rgb(255, 255, 255)";
        font_size = 72;
        position = {
          x = 0;
          y = 250;
        };
        halign = "center";
        valign = "center";
      }
      {
        text = "Hey, <i>$USER!</i>";
        color = "rgb(255, 255, 255)";
        font_size = 36;
        position = {
          x = 0;
          y = 30;
        };
        halign = "center";
        valign = "center";
      }
    ];
  };
}
