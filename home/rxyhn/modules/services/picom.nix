{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    shadow = true;
    shadowOffsets = [(-40) (-40)];
    shadowOpacity = 0.55;
    shadowExclude = [
      "class_g = 'slop'"
      "window_type = 'menu'"
      "window_type = 'dock'"
      "window_type = 'desktop'"
      "class_g = 'Peek'"
      "class_g = 'firefox' && window_type = 'utility'"
      "_GTK_FRAME_EXTENTS@:c"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      "class_g *?= 'zoom'"
      "name = 'cpt_frame_window'"
      "name = 'as_toolbar'"
      "name = 'cpt_frame_xcb_window'"
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
      dock = {
        shadow = true;
        clip-shadow-above = false;
        full-shadow = true;
      };
      dropdown_menu = {full-shadow = true;};
      normal = {full-shadow = true;};
      notification = {full-shadow = true;};
      popup_menu = {full-shadow = true;};
      tooltip = {
        fade = true;
        shadow = true;
        focus = true;
        full-shadow = true;
      };
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
      kernel = "11x11gaussian";
      blur-size = 12;
      blur-strength = 8;
      blur-background = false;
      blur-background-frame = true;
      blur-background-fixed = true;
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      glx-no-stencil = true;
      use-damage = true;
      transparent-clipping = false;
      log-level = "warn";
    };
  };
}
