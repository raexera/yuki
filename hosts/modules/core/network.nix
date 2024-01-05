{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [speedtest-cli bandwhich];

  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
