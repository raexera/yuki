{
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      dns = "systemd-resolved";
    };

    useDHCP = false;
  };

  services.resolved = {
    enable = true;
  };
}
