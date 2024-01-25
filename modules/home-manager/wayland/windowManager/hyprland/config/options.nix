{
  config,
  themes,
  ...
}: {
  wayland.windowManager.hyprland.settings = let
    pointer = config.home.pointerCursor;

    inherit (themes.colorscheme) colors;
  in {
    env = [
      "GDK_SCALE,2"
      "WLR_DRM_NO_ATOMIC,1"
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
      gaps_in = 2;
      gaps_out = 4;
      border_size = 2;

      "col.active_border" = "rgb(${colors.blue}) rgb(${colors.pink}) 45deg";

      allow_tearing = true;
      resize_on_border = true;
    };

    decoration = {
      rounding = 8;

      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 5;
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
        "md3_decel, 0.05, 0.7, 0.1, 1"
      ];

      animation = [
        "border, 1, 2, default"
        "fade, 1, 2, md3_decel"
        "windows, 1, 4, md3_decel, popin 60%"
        "workspaces, 1, 4, md3_decel, slidevert"
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
        scroll_factor = 0.5;
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
      focus_on_activate = true;
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
