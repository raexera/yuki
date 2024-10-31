{
  config,
  themes,
  ...
}: let
  pointer = config.home.pointerCursor;
  cursorName = "Bibata-Modern-Classic-Hyprcursor";
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
      rounding = 16;
      blur.enabled = false;
      drop_shadow = false;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
    };

    animations = {
      enabled = true;

      bezier = [
        "myBezier, 0.25, 1, 0.5, 1"
      ];

      animation = [
        "windows, 1, 5, myBezier, popin 75%"
        "windowsIn, 1, 5, myBezier, popin 75%"
        "windowsOut, 1, 5, myBezier, popin 75%"
        "windowsMove, 1, 5, default"
        "border, 1, 10, default"
        "fade, 1, 5, myBezier"
        "workspaces, 1, 5, myBezier, slide"
        "specialWorkspace, 1, 5, myBezier, slidevert"
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
