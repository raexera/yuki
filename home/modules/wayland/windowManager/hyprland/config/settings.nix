{
  config,
  themes,
  ...
}: let
  pointer = config.home.pointerCursor;
  cursorName = "Bibata-Modern-Ice-Hyprcursor";
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

      border_size = 1;
      "col.active_border" = "rgba(88888888)";
      "col.inactive_border" = "rgba(00000088)";

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

      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.02;
        passes = 3;
        popups = true;
        size = 10;
      };

      active_opacity = 1.0;
      inactive_opacity = 1.0;
      fullscreen_opacity = 1.0;

      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_offset = "0 15";
      shadow_range = 100;
      shadow_render_power = 2;
      shadow_scale = 0.97;
      "col.shadow" = "rgba(00000055)";
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

    plugin = {
      hyprbars = let
        inherit (themes.colorscheme.colors) normal;
      in {
        bar_height = 20;
        bar_precedence_over_border = true;

        # Order is right-to-left
        hyprbars-button = [
          # close
          "rgb(${normal.red}), 15, 󰖭, hyprctl dispatch killactive"
          # maximize
          "rgb(${normal.blue}), 15, 󰖯, hyprctl dispatch fullscreen 1"
        ];
      };
    };
  };
}
