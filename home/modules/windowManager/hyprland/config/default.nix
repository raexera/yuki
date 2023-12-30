{config, ...}: {
  imports = [
    ./rules.nix
    ./binds.nix
  ];

  wayland.windowManager.hyprland.settings = let
    pointer = config.home.pointerCursor;
  in {
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    ];

    exec-once = [
      "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 5;
      border_size = 1;
      "col.active_border" = "rgba(88888888)";
      "col.inactive_border" = "rgba(00000088)";

      allow_tearing = true;
    };

    decoration = {
      rounding = 16;
      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.02;

        passes = 3;
        size = 10;
      };

      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 3;
      "col.shadow" = "rgba(00000055)";
    };

    animations = {
      enabled = true;
      animation = [
        "border, 1, 2, default"
        "fade, 1, 4, default"
        "windows, 1, 3, default, popin 80%"
        "workspaces, 1, 2, default, slide"
      ];
    };

    group = {
      groupbar = {
        font_size = 16;
        gradients = false;
      };

      "col.active_border" = "rgba(33 ccffee)";
      "col.inactive_border" = "rgba(595959 aa)";
    };

    input = {
      kb_layout = "us";

      follow_mouse = 1;
      accel_profile = "flat";
      touchpad.scroll_factor = 0.1;
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    misc = {
      disable_autoreload = true;
      force_default_wallpaper = 0;
      animate_mouse_windowdragging = false;
      vrr = 1;
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    xwayland.force_zero_scaling = true;

    debug.disable_logs = false;
  };

  wayland.windowManager.hyprland.extraConfig = ''
    monitor =,highres,auto,2
  '';
}
