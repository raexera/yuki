{config, ...}: {
  wayland.windowManager.hyprland.settings = let
    pointer = config.home.pointerCursor;
  in {
    env = [
      "GDK_SCALE,2"
    ];

    exec-once = [
      "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
    ];

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_is_master = true;
    };

    general = {
      gaps_in = 5;
      gaps_out = 5;
      border_size = 1;
      "col.active_border" = "rgba(88888888)";
      "col.inactive_border" = "rgba(00000088)";

      allow_tearing = true;
      resize_on_border = true;
    };

    decoration = {
      rounding = 8;

      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 3;
      "col.shadow" = "rgba(00000055)";

      blur = {
        enabled = false;
        brightness = 1.0;
        contrast = 1.0;
        new_optimizations = true;
        noise = 0.02;
        passes = 4;
        size = 10;
        xray = true;
      };
    };

    animations = {
      enabled = true;

      bezier = [
        "smoothOut, 0.36, 0, 0.66, -0.56"
        "smoothIn, 0.25, 1, 0.5, 1"
        "overshot, 0.4, 0.8, 0.2, 1.2"
      ];

      animation = [
        "border, 1, 10, default"
        "fade, 1, 10, smoothIn"
        "fadeDim, 1, 10, smoothIn"
        "windows, 1, 4, overshot, slide"
        "windowsOut, 1, 4, smoothOut, slide"
        "workspaces,1, 4, overshot,slidevert"
      ];
    };

    input = {
      kb_layout = "us";
      kb_options = "caps:backspace";

      accel_profile = "flat";
      follow_mouse = 1;

      touchpad = {
        disable_while_typing = true;
        natural_scroll = true;
        scroll_factor = 0.1;
      };
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    misc = {
      animate_mouse_windowdragging = false;
      disable_autoreload = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_hypr_chan = true;
      force_default_wallpaper = 0;
      key_press_enables_dpms = true;
      mouse_move_enables_dpms = true;
      vfr = true;
      vrr = 2;
    };

    monitor = [
      # name, resolution, position, scale
      "eDP-1, highres, auto, 2"
    ];

    xwayland.force_zero_scaling = true;
  };
}
