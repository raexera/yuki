{
  config,
  pkgs,
  lib,
  ...
}: {
  virtualisation.docker.enable = true;
  networking = {
    # dns
    nameservers = ["1.1.1.1" "1.0.0.1"];
    networkmanager = {
      enable = true;
    };
  };
  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
}
