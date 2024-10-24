{
  config,
  themes,
  ...
}: let
  pointer = config.home.pointerCursor;
  cursorName = "Bibata-Modern-Ice-Hyprcursor";
  inherit (themes.colorscheme) colors;
in {
  wayland.windowManager.hyprland.settings = {
    env = [
      "GDK_SCALE,2"
      "HYPRCURSOR_THEME,${cursorName}"
      "HYPRCURSOR_SIZE,${toString pointer.size}"
    ];

    exec-once = [
      "hyprctl setcursor ${cursorName} ${toString pointer.size}"
    ];

    general = {
      gaps_in = 2;
      gaps_out = 4;

      border_size = 3;
      "col.active_border" = "rgb(${colors.accent})";
      "col.inactive_border" = "rgb(${colors.background_dark})";

      resize_on_border = true;
      allow_tearing = true;

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
      rounding = 16;
      blur.enabled = false;
      drop_shadow = false;
    };

    animations = {
      enabled = true;

      bezier = [
        "quart, 0.25, 1, 0.5, 1"
      ];

      animation = [
        "windows, 1, 5, quart, slide"
        "fade, 1, 5, quart"
        "border, 1, 5, quart"
        "workspaces, 1, 5, quart, slide"
      ];
    };

    input = {
      kb_layout = "us";
      kb_options = "caps:backspace";

      follow_mouse = 1;
      accel_profile = "flat";

      touchpad = {
        disable_while_typing = true;
        scroll_factor = 0.5;
      };
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    group = {
      groupbar = {
        font_size = 16;
        gradients = false;
      };
    };

    misc = {
      disable_autoreload = true;
      disable_hyprland_logo = true;
      force_default_wallpaper = 0;
      vfr = true;
      vrr = 1;
    };

    cursor.no_hardware_cursors = true;
    debug.disable_logs = false;
    render.direct_scanout = true;
    xwayland.force_zero_scaling = true;
  };
}
