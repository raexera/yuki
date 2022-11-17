{
  config,
  pkgs,
  lib,
  ...
}: {
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [443 80 22];
      allowedUDPPorts = [443 80];
      allowPing = false;
      logReversePathDrops = true;
    };
  };

  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
}
