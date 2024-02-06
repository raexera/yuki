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

    useDHCP = false;
  };

  services = {
    resolved.enable = true;
    gnome.glib-networking.enable = true;
  };
}
