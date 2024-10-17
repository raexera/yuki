{
  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        powersave = true;
      };
    };
  };

  programs = {
    nm-applet.enable = true;
  };

  services = {
    gnome.glib-networking.enable = true;
    resolved.enable = true;
  };
}
