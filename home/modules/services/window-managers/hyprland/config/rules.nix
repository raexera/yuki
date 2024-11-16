{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "dimaround, class:^(gcr-prompter)$"
      "dimaround, class:^(polkit-gnome-authentication-agent-1)$"
      "dimaround, class:^(xdg-desktop-portal-gtk)$"

      "float, class:^(io.bassi.Amberol)$"
      "float, class:^(io.github.celluloid_player.Celluloid)$"
      "float, class:^(mpv|celluloid)$"
      "float, class:^(nm-applet|nm-connection-editor|blueman-manager)$"
      "float, class:^(org.gnome.Calculator)$"
      "float, class:^(org.gnome.Loupe)$"
      "float, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
      "float, class:^(thunar)$"
      "float, class:^(xdg-desktop-portal-gtk)$"

      "float, title:^(Open Files?|All Files|Open Folder|Install from VSIX)$"
      "float, title:^(Media viewer)$"

      "float,title:(Authentication Required|Picture-in-Picture)"
      "pin,title:(Authentication Required|Picture-in-Picture)"

      "idleinhibit fullscreen, class:^(*)$"
      "idleinhibit fullscreen, title:^(*)$"
      "idleinhibit fullscreen, fullscreen:1"

      "suppressevent maximize, class:.*"
    ];
  };
}
