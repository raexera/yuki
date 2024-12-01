{config, ...}: {
  wayland.windowManager.hyprland.settings = let
    pointer = config.home.pointerCursor;
    inherit (config.theme.colorscheme) colors;
  in {
    env = [
      "CLUTTER_BACKEND,wayland"
      "GDK_BACKEND,wayland,x11,*"
      "SDL_VIDEODRIVER,wayland"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "QT_STYLE_OVERRIDE,kvantum"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "GTK_THEME,${config.gtk.theme.name}"
      "XCURSOR_THEME,${pointer.name}"
      "XCURSOR_SIZE,${toString pointer.size}"
    ];

    exec-once = [
      "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 10;

      border_size = 2;
      "col.active_border" = "rgb(${colors.blue})";
      "col.inactive_border" = "rgb(${colors.gray0})";

      resize_on_border = true;

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false;

      layout = "dwindle";
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_status = "master";
    };

    decoration = {
      rounding = 12;

      active_opacity = 1.0;
      inactive_opacity = 1.0;
      fullscreen_opacity = 1.0;

      dim_inactive = false;

      blur.enabled = false;
      shadow.enabled = false;
    };

    animations = {
      enabled = true;
      first_launch_animation = true;

      bezier = [
        "easeOutQuart, 0.25, 1, 0.5, 1"
      ];

      animation = [
        "windows, 1, 3, easeOutQuart, slide"
        "layers, 1, 3, easeOutQuart, fade"
        "fade, 1, 3, easeOutQuart"
        "border, 1, 5, easeOutQuart"
        "workspaces, 1, 5, easeOutQuart, slide"
        "specialWorkspace, 1, 5, easeOutQuart, slidevert"
      ];
    };

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      accel_profile = "flat";

      touchpad = {
        disable_while_typing = true;
        natural_scroll = true;
        tap-to-click = true;
        tap-and-drag = true;
        scroll_factor = 0.5;
      };
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    misc = {
      animate_manual_resizes = true;
      animate_mouse_windowdragging = true;
      disable_autoreload = true;
      disable_hyprland_logo = true;
      force_default_wallpaper = 0;
      vfr = true;
      vrr = 1;
    };

    binds = {
      allow_workspace_cycles = true;
    };

    xwayland = {
      enabled = true;
      force_zero_scaling = true;
    };

    plugin = {
      hyprexpo = {
        columns = 3;
        gap_size = 4;
        bg_col = "rgb(${colors.black0})";
        enable_gesture = true;
        gesture_fingers = 3;
        gesture_distance = 300;
        gesture_positive = false;
      };
    };
  };
}
