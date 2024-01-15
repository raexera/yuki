{lib, ...}: {
  imports = [
    ./ssh.nix
    ./warp.nix
  ];

  networking = {
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
        powersave = true;
      };
    };

    useDHCP = false;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
