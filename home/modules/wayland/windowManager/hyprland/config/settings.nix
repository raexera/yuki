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
        "quart, 0.25, 1, 0.5, 1"
      ];

      animation = [
        "windows, 1, 3, quart, popin 60%"
        "windowsIn, 1, 3, quart, popin 60%"
        "windowsOut, 1, 3, quart, popin 60%"
        "windowsMove, 1, 3, quart, slide"
        "layers, 1, 3, quart, slide"
        "layersIn, 1, 3, quart, slide"
        "layersOut, 1, 3, quart"
        "fade, 1, 5, quart"
        "border, 1, 10, default"
        "workspaces, 1, 5, quart, slide"
        "specialWorkspace, 1, 5, quart, slidevert"
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
      animate_manual_resizes = true;
      animate_mouse_windowdragging = true;
      disable_autoreload = true;
      disable_hyprland_logo = true;
      focus_on_activate = true;
      force_default_wallpaper = 0;
      vfr = true;
      vrr = 1;
    };

    xwayland = {
      enabled = true;
      force_zero_scaling = true;
    };
  };
}
