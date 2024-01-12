{
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "ignorezero, ^(gtk-layer-shell)$"
      "ignorezero, bar"
      "ignorezero, launcher"
      "ignorezero, lockscreen"
      "ignorezero, notifications"
    ];

    windowrulev2 = [
      "float, class:^(imv)$"
      "float, class:^(wofi)$"
      "float, title:^(com.github.Aylur.ags)$"
      "float, title:^(Media viewer)$"
      "float, title:^(Picture-in-Picture)$"
      "idleinhibit fullscreen, class:^(firefox)$"
      "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
      "idleinhibit focus, class:^(mpv)$"
      "pin, title:^(Picture-in-Picture)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
    ];
  };
}
