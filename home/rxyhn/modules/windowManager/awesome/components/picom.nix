{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    shadow = true;
    shadowOffsets = [(-40) (-20)];
    shadowOpacity = 0.55;
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
      "_GTK_FRAME_EXTENTS@:c"
      "window_type = 'dock'"
    ];

    fade = true;
    fadeDelta = 10;
    fadeSteps = [0.03 0.03];
    fadeExclude = [];

    activeOpacity = 1.0;
    inactiveOpacity = 1.0;
    menuOpacity = 1.0;
    opacityRules = ["70:class_g = 'splash'"];

    wintypes = {
      tooltip = {
        fade = true;
        shadow = true;
        focus = true;
        full-shadow = true;
      };
      dock = {shadow = false;};
      dnd = {shadow = false;};
      popup_menu = {opacity = 1;};
      dropdown_menu = {opacity = 1;};
      desktop = {full-shadow = false;};
      normal = {full-shadow = false;};
    };

    settings = {
      shadow-radius = 40;
      shadow-color = "#000000";
      shadow-ignore-shaped = false;

      frame-opacity = 1.0;
      inactive-opacity-override = false;
      focus-exclude = [
        "class_g = 'Peek'"
        "class_g = 'Cairo-clock'"
      ];

      corner-radius = 12;
      rounded-corners-exclude = [];

      blur-method = "dual_kawase";
      blur-kernel = "11x11gaussian";
      blur-size = 6;
      blur-deviation = 1.0;
      blur-strength = 12;
      blur-background = false;
      blur-background-frame = true;
      blur-background-fixed = true;
      blur-background-exclude = [
        "class_g = 'slop'"
        "class_g = 'firefox'"
        "_GTK_FRAME_EXTENTS@:c"
        "window_type = 'desktop'"
        "window_type = 'menu'"
      ];

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      glx-no-stencil = true;
      use-damage = true;
      transparent-clipping = false;
      log-level = "warn";
    };
  };
}
