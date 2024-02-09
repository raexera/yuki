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

  services = {
    gnome.glib-networking.enable = true;
    resolved.enable = true;
  };
}
