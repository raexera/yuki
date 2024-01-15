{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "float, class:^(imv)$"
      "float, class:^(nm-connection-editor)$"
      "float, class:^(org.gnome.Nautilus)$"
      "float, class:^(pavucontrol)$"
      "float, class:^(xdg-desktop-portal)$"
      "float, class:^(xdg-desktop-portal-gtk)$"
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
