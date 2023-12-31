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
      border_size = 2;
      gaps_in = 5;
      gaps_out = 5;
      "col.inactive_border" = "rgba(595959aa)";
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      layout = "dwindle";
      allow_tearing = false;
    };

    decoration = {
      rounding = 8;
      drop_shadow = false;
      shadow_ignore_window = true;
      blur = {
        enabled = true;
        size = 8;
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
        "overshot, 0.4,0.8,0.2,1.2"
      ];

      animation = [
        "windows, 1, 4, overshot, slide"
        "windowsOut, 1, 4, smoothOut, slide"
        "border,1,10,default"

        "fade, 1, 10, smoothIn"
        "fadeDim, 1, 10, smoothIn"
        "workspaces,1,4,overshot,slidevert"
      ];
    };

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      sensitivity = 0;
      accel_profile = "flat";
      touchpad = {
        natural_scroll = true;
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
      disable_autoreload = true;
      disable_splash_rendering = true;
      disable_hyprland_logo = true;
      force_hypr_chan = true;
      force_default_wallpaper = 0;
      animate_mouse_windowdragging = false;
      vfr = true;
      vrr = 1;
    };

    xwayland.force_zero_scaling = true;
    debug.disable_logs = false;
  };

  wayland.windowManager.hyprland.extraConfig = ''
    monitor =,highres,auto,2
  '';
}
