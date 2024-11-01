{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "dimaround, class:^(gcr-prompter)$"
      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, class:^(polkit-gnome-authentication-agent-1)$"
      "float, class:^(imv)$"
      "float, class:^(io.bassi.Amberol)$"
      "float, class:^(io.github.celluloid_player.Celluloid)$"
      "float, class:^(nm-connection-editor)$"
      "float, class:^(org.gnome.Loupe)$"
      "float, class:^(pavucontrol)$"
      "float, class:^(thunar)$"
      "float, class:^(xdg-desktop-portal-gtk)$"
      "float, title:^(Media viewer)$"
      "float,title:^(Open Files?|All Files|Open Folder|Install from VSIX)$"
      "float, title:^(Picture-in-Picture)$"
      "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
      "idleinhibit focus, class:^(brave-browser)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(brave-browser)$"
      "pin, title:^(Picture-in-Picture)$"
    ];
  };
}
