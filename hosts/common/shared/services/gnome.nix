{pkgs, ...}: {
  services = {
    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    udev.packages = with pkgs; [gnome.gnome-settings-daemon];
  };
}
