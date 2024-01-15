{lib, ...}: {
  imports = [
    ./ssh.nix
    ./warp.nix
  ];

  networking = {
    networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
      };
    };

    useDHCP = false;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
