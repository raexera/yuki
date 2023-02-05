{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./shared
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "Inter";
      size = 13;
    };

    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-decoration-layout = "menu:";
    };

    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };

  home.pointerCursor = {
    name = "macOS-Monterey";
    package = pkgs.macos-cursors;
    size = 48;
    gtk.enable = true;
  };

  home.sessionVariables = {
    # Theming Related Variables
    GTK_THEME = "Colloid-Dark";
    XCURSOR_SIZE = "48";
  };

  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    shadow = true;
    shadowOffsets = [(-40) (-20)];
    shadowOpacity = 0.55;
    shadowExclude = [
      "_GTK_FRAME_EXTENTS@:c"
      "_PICOM_SHADOW@:32c = 0"
      "_NET_WM_WINDOW_TYPE:a = '_NET_WM_WINDOW_TYPE_NOTIFICATION'"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      "class_g = 'Conky'"
      "class_g = 'slop'"
      "window_type = 'combo'"
      "window_type = 'desktop'"
      "window_type = 'dnd'"
      "window_type = 'dock'"
      "window_type = 'dropdown_menu'"
      "window_type = 'menu'"
      "window_type = 'notification'"
      "window_type = 'popup_menu'"
      "window_type = 'splash'"
      "window_type = 'toolbar'"
      "window_type = 'utility'"
    ];

    fade = true;
    fadeDelta = 10;
    fadeSteps = [0.03 0.03];
    fadeExclude = [
      "window_type = 'combo'"
      "window_type = 'desktop'"
      "window_type = 'dock'"
      "window_type = 'dnd'"
      "window_type = 'notification'"
      "window_type = 'toolbar'"
      "window_type = 'unknown'"
      "window_type = 'utility'"
      "_PICOM_FADE@:32c = 0"
    ];

    activeOpacity = 1.0;
    inactiveOpacity = 1.0;
    menuOpacity = 1.0;
    opacityRules = ["70:class_g = 'splash'"];

    wintypes = {
      tooltip = {
        fade = true;
        shadow = true;
        focus = true;
        full-shadow = true;
      };
      dock = {shadow = false;};
      dnd = {shadow = false;};
      popup_menu = {opacity = 1;};
      dropdown_menu = {opacity = 1;};
      desktop = {full-shadow = false;};
      normal = {full-shadow = false;};
    };

    settings = {
      shadow-radius = 40;
      shadow-color = "#000000";
      shadow-ignore-shaped = false;

      frame-opacity = 1.0;
      inactive-opacity-override = false;
      focus-exclude = [
        "class_g = 'Cairo-clock'"
        "class_g = 'Peek'"
        "class_g = 'slop'"
        "window_type = 'combo'"
        "window_type = 'desktop'"
        "window_type = 'dialog'"
        "window_type = 'dnd'"
        "window_type = 'dock'"
        "window_type = 'dropdown_menu'"
        "window_type = 'menu'"
        "window_type = 'tooltip'"
        "window_type = 'unknown'"
        "window_type = 'utility'"
      ];

      corner-radius = 22;
      rounded-corners-exclude = [
        "_PICOM_SHADOW@:32c = 0"
        "window_type = 'dock'"
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_MAXIMIZED_VERT'"
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_MAXIMIZED_HORZ'"
      ];

      blur-method = "dual_kawase";
      blur-kernel = "11x11gaussian";
      blur-deviation = 1.0;
      blur-strength = 10;
      blur-background = true;
      blur-background-frame = true;
      blur-background-fixed = true;
      blur-background-exclude = [
        "_GTK_FRAME_EXTENTS@:c"
        "window_type = 'combo'"
        "window_type = 'desktop'"
        "window_type = 'dnd'"
        "window_type = 'menu'"
        "window_type = 'toolbar'"
        "window_type = 'tooltip'"
        "window_type = 'utility'"
        "window_type = 'unknown'"
        "class_g = 'firefox' && window_type != 'normal'"
        "class_g = 'slop'"
      ];

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      glx-no-stencil = true;
      use-damage = true;
      transparent-clipping = false;
      unredir-if-possible = false;
      log-level = "warn";
    };
  };

  xresources.extraConfig = ''
    Xft.dpi: 144
    Xft.antialias: true
    Xft.hinting: true
    Xft.rgba: rgb
    Xft.autohint: false
    Xft.hintstyle: hintfull
    Xft.lcdfilter: lcddefault

    Xcursor.size: 48

    *background: #1E1E2E
    *foreground: #CDD6F4

    ! black
    *color0: #45475A
    *color8: #585B70

    ! red
    *color1: #F38BA8
    *color9: #F38BA8

    ! green
    *color2: #A6E3A1
    *color10: #A6E3A1

    ! yellow
    *color3: #F9E2AF
    *color11: #F9E2AF

    ! blue
    *color4: #89B4FA
    *color12: #89B4FA

    ! magenta
    *color5: #F5C2E7
    *color13: #F5C2E7

    ! cyan
    *color6: #94E2D5
    *color14: #94E2D5

    ! white
    *color7: #BAC2DE
    *color15: #A6ADC8
  '';
}
