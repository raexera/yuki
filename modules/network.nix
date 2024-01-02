{pkgs, ...}: {
  environment.systemPackages = with pkgs; [speedtest-cli bandwhich];

  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi = {
        macAddress = "random";
        powersave = true;
      };
    };
  };

  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };

    resolved.enable = true;
  };

  # systemd.services.NetworkManager-wait-online.enable = false;
}
