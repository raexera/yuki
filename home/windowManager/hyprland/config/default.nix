{config, ...}: {
  imports = [
    ./rules.nix
    ./binds.nix
  ];

  wayland.windowManager.hyprland.settings = let
    pointer = config.home.pointerCursor;
  in {
    exec-once = [
      "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 5;
      border_size = 1;
      "col.active_border" = "rgba(88888888)";
      "col.inactive_border" = "rgba(00000088)";

      allow_tearing = false;
    };

    decoration = {
      rounding = 12;
      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 3;
      "col.shadow" = "rgba(00000055)";
      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        size = 10;
        passes = 4;
        new_optimizations = true;
        xray = true;
      };
    };

    animations = {
      enabled = true;
      first_launch_animation = false;

      bezier = [
        "smoothOut, 0.36, 0, 0.66, -0.56"
        "smoothIn, 0.25, 1, 0.5, 1"
        "overshot, 0.4, 0.8, 0.2, 1.2"
      ];

      animation = [
        "windows, 1, 4, overshot, slide"
        "windowsOut, 1, 4, smoothOut, slide"
        "border, 1, 10, default"

        "fade, 1, 10, smoothIn"
        "fadeDim, 1, 10, smoothIn"
        "workspaces,1, 4, overshot,slide"
      ];
    };

    input = {
      kb_layout = "us";
      kb_options = "caps:backspace";
      follow_mouse = 1;
      sensitivity = 0;
      accel_profile = "flat";
      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
      };
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_is_master = true;
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
      vrr = 0;
    };

    monitor = [
      ",highres,auto,2"
    ];

    xwayland.force_zero_scaling = true;
    debug.disable_logs = false;
  };
}
