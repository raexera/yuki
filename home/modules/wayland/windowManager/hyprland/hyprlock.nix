{
  inputs,
  themes,
  ...
}: {
  imports = [
    inputs.hyprlock.homeManagerModules.hyprlock
  ];

  programs.hyprlock = {
    enable = true;
    backgrounds = [{path = "${themes.wallpaper}";}];
    labels = [
      {
        text = "$TIME";
        color = "rgba(0, 0, 0, 0.8)";
        font_size = 50;
        font_family = "monospace";
        position = {
          x = 0;
          y = 250;
        };
      }
      {
        text = "Hey, $USER!";
        color = "rgba(0, 0, 0, 0.8)";
        position = {
          x = 0;
          y = 30;
        };
      }
    ];

    input-fields = [
      {
        outline_thickness = 1;
        dots_spacing = 0.3;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0)";
        font_color = "rgba(255, 255, 255, 0.5)";
        fade_on_empty = false;
        hide_input = false;
        position = {
          x = 0;
          y = -30;
        };
      }
    ];
  };
}
