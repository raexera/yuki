{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    shadow = true;
    shadowOffsets = [(-40) (-40)];
    shadowOpacity = 0.4;

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

    fadeExclude = [
      "class_g = 'Peek'"
    ];

    opacityRules = ["70:class_g = 'splash'"];

    wintypes = {
      popup_menu = {full-shadow = true;};
      dropdown_menu = {full-shadow = true;};
      notification = {full-shadow = true;};
      normal = {full-shadow = true;};
    };

    settings = {
      shadow-radius = 40;

      focus-exclude = [
        "class_g = 'Peek'"
      ];

      corner-radius = 0; #8
      rounded-corners-exclude = ["!window_type = 'normal' && !window_type = 'dialog'"];

      blur-method = "dual_kawase";
      blur-strength = 7.0;
      kernel = "11x11gaussian";
      blur-background = false;
      blur-background-frame = true;
      blur-background-fixed = true;

      blur-background-exclude = ["!window_type = 'splash'"];
    };
  };
}
