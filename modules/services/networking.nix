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

    firewall = {
      enable = true;
      allowedTCPPorts = [
        8081
        4321
      ];
      checkReversePath = "loose";
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
