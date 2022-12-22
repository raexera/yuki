''
  # Monitors
  monitor = eDP-1, preferred, auto, auto

  # Autostart programs
  exec-once = xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2

  # Input
  input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =
    follow_mouse = 1
    touchpad {
        disable_while_typing = true
        natural_scroll = true
        tap-to-click = true
    }
    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
  }

  # General
  general {
    gaps_in = 6
    gaps_out = 12
    border_size = 2
    col.active_border=0xffcba6f7
    col.inactive_border=0xff313244
    no_border_on_floating = true
    layout = dwindle
    main_mod = SUPER
  }

  # Misc
  misc {
    disable_hyprland_logo = true
    disable_splash_rendering = true
    mouse_move_enables_dpms = true
    no_vfr = false
    enable_swallow = true
    swallow_regex = ^(kitty)$
  }

  # Decorations
  decoration {
    # Rounded corners
    rounding = 8
    multisample_edges = true

    # Opacity
    active_opacity = 1.0
    inactive_opacity = 1.0

    # Blur
    blur = true
    blur_size = 10
    blur_passes = 4
    blur_new_optimizations = true

    # Shadow
    drop_shadow = true
    shadow_ignore_window = true
    shadow_offset = 2 2
    shadow_range = 4
    shadow_render_power = 2
    col.shadow = 0x66000000
  }

  # Blurring layerSurfaces
  blurls = gtk-layer-shell
  blurls = waybar
  blurls = lockscreen

  # Animations
  animations {
    enabled = true

    # bezier curve
    bezier = overshot, 0.05, 0.9, 0.1, 1.05
    # bezier = overshot, 0.13, 0.99, 0.29, 1.1
    bezier = smoothOut, 0.36, 0, 0.66, -0.56
    bezier = smoothIn, 0.25, 1, 0.5, 1

    # animation list
    animation = windows, 1, 5, overshot, slide
    animation = windowsOut, 1, 4, smoothOut, slide
    animation = windowsMove, 1, 4, default
    animation = border, 1, 10, default
    animation = fade, 1, 10, smoothIn
    animation = fadeDim, 1, 10, smoothIn
    animation = workspaces, 1, 6, overshot, slidevert
  }

  # Gestures
  gestures {
    workspace_swipe = true
    workspace_swipe_fingers = 3
  }

  # Layouts
  dwindle {
    col.group_border_active=0xff89b4fa
    col.group_border=0xff585b70
    no_gaps_when_only = true
    pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true # you probably want this
  }

  # Window rules
  windowrule = float, file_progress
  windowrule = float, confirm
  windowrule = float, dialog
  windowrule = float, download
  windowrule = float, notification
  windowrule = float, error
  windowrule = float, splash
  windowrule = float, confirmreset
  windowrule = float, title:Open File
  windowrule = float, title:branchdialog
  windowrule = float, zoom
  windowrule = float, vlc
  windowrule = float, Lxappearance
  windowrule = float, ncmpcpp
  windowrule = float, Rofi
  windowrule = animation none, Rofi
  windowrule = float, viewnior
  windowrule = float, pavucontrol-qt
  windowrule = float, gucharmap
  windowrule = float, gnome-font
  windowrule = float, org.gnome.Settings
  windowrule = float, file-roller
  windowrule = float, nautilus
  windowrule = float, nemo
  windowrule = float, thunar
  windowrule = float, Pcmanfm
  windowrule = float, obs
  windowrule = float, wdisplays
  windowrule = float, zathura
  windowrule = float, *.exe
  windowrule = fullscreen, wlogout
  windowrule = float, title:wlogout
  windowrule = fullscreen, title:wlogout
  windowrule = float, pavucontrol-qt
  windowrule = float, keepassxc
  windowrule = idleinhibit focus, mpv
  windowrule = idleinhibit fullscreen, firefox
  windowrule = float, title:^(Media viewer)$
  windowrule = float, title:^(Transmission)$
  windowrule = float, title:^(Volume Control)$
  windowrule = float, title:^(Picture-in-Picture)$
  windowrule = float, title:^(Firefox — Sharing Indicator)$
  windowrule = move 0 0, title:^(Firefox — Sharing Indicator)$
  windowrule = size 800 600, title:^(Volume Control)$
  windowrule = move 75 44%, title:^(Volume Control)$

  # Variables
  $term = kitty
  $browser = firefox
  $editor = code
  $files = nemo
  $launcher = killall rofi || rofi -no-lazy-grab -show drun -theme index
  $emoji = killall rofi || rofi -show emoji -emoji-format "{emoji}" -modi emoji -theme emoji

  # Apps
  bind = SUPER, RETURN, exec, run-as-service $term
  bind = SUPER SHIFT, E, exec, $editor
  bind = SUPER SHIFT, F, exec, $files
  bind = SUPER SHIFT, B, exec, $browser
  bind = SUPER, D, exec, $launcher
  bind = SUPER, E, exec, $emoji
  bind = SUPER, X, exec, power-menu

  # Function keys
  bind = ,XF86MonBrightnessUp, exec, brightness set +5%
  bind = ,XF86MonBrightnessDown, exec, brightness set 5%-
  bind = ,XF86AudioRaiseVolume, exec, volume -i 5
  bind = ,XF86AudioLowerVolume, exec, volume -d 5
  bind = ,XF86AudioMute, exec, volume -t
  bind = ,XF86AudioMicMute, exec, microphone -t

  # Screenshots
  $screenshotarea = hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copysave area; hyprctl keyword animation "fadeOut,1,4,default"
  bind = , Print, exec, $screenshotarea
  bind = CTRL, Print, exec, grimblast --notify --cursor copysave output
  bind = SUPER SHIFT CTRL, R, exec, grimblast --notify --cursor copysave output
  bind = ALT, Print, exec, grimblast --notify --cursor copysave screen
  bind = SUPER SHIFT ALT, R, exec, grimblast --notify --cursor copysave screen

  # Misc
  bind = CTRL ALT, L, exec, swaylock
  bind = SUPER SHIFT, O, exec, run-as-service wl-ocr

  # Window management
  bind = SUPER, Q, killactive,
  bind = SUPER, M, exit,
  bind = SUPER, F, fullscreen,
  bind = SUPER, Space, togglefloating,
  bind = SUPER, P, pseudo, # dwindle
  bind = SUPER, J, togglesplit, # dwindle

  # Focus
  bind = SUPER, left, movefocus, l
  bind = SUPER, right, movefocus, r
  bind = SUPER, up, movefocus, u
  bind = SUPER, down, movefocus, d

  # Move
  bind = SUPER SHIFT, left, movewindow, l
  bind = SUPER SHIFT, right, movewindow, r
  bind = SUPER SHIFT, up, movewindow, u
  bind = SUPER SHIFT, down, movewindow, d

  # Resize
  bind = SUPER CTRL, left, resizeactive, -20 0
  bind = SUPER CTRL, right, resizeactive, 20 0
  bind = SUPER CTRL, up, resizeactive, 0 -20
  bind = SUPER CTRL, down, resizeactive, 0 20

  # Tabbed
  bind= SUPER, g, togglegroup
  bind= SUPER, tab, changegroupactive

  # Special workspace
  bind = SUPER, grave, togglespecialworkspace
  bind = SUPERSHIFT, grave, movetoworkspace, special

  # Switch workspaces
  bind = SUPER, 1, workspace, 1
  bind = SUPER, 2, workspace, 2
  bind = SUPER, 3, workspace, 3
  bind = SUPER, 4, workspace, 4
  bind = SUPER, 5, workspace, 5
  bind = SUPER, 6, workspace, 6
  bind = SUPER, 7, workspace, 7
  bind = SUPER, 8, workspace, 8
  bind = SUPER, 9, workspace, 9
  bind = SUPER, 0, workspace, 10
  bind = SUPER ALT, up, workspace, e+1
  bind = SUPER ALT, down, workspace, e-1

  # Move active window to a workspace
  bind = SUPER SHIFT, 1, movetoworkspace, 1
  bind = SUPER SHIFT, 2, movetoworkspace, 2
  bind = SUPER SHIFT, 3, movetoworkspace, 3
  bind = SUPER SHIFT, 4, movetoworkspace, 4
  bind = SUPER SHIFT, 5, movetoworkspace, 5
  bind = SUPER SHIFT, 6, movetoworkspace, 6
  bind = SUPER SHIFT, 7, movetoworkspace, 7
  bind = SUPER SHIFT, 8, movetoworkspace, 8
  bind = SUPER SHIFT, 9, movetoworkspace, 9
  bind = SUPER SHIFT, 0, movetoworkspace, 10

  # Mouse bindings
  bindm = SUPER, mouse:272, movewindow
  bindm = SUPER, mouse:273, resizewindow
  bind = SUPER, mouse_down, workspace, e+1
  bind = SUPER, mouse_up, workspace, e-1
''
