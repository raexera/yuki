{
  networking = {
    networkmanager = {
      enable = true;
      unmanaged = ["docker0" "rndis0"];
      wifi.macAddress = "random";
    };

    firewall = {
      enable = true;
      allowPing = false;
      logReversePathDrops = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
