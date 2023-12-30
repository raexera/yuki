{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez5-experimental;
  };

  systemd.user.services.telephony_client.enable = false;
}
