{lib, ...}: {
  imports = [
    ./ssh.nix
  ];

  networking = {
    extraHosts = builtins.readFile (
      builtins.fetchurl {
        url = "https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts";
        sha256 = "18a1q92jg5558hviw3wxp9z6k9zpmr6k5kk1mzfiwm6pnyrg8bp5";
      }
    );

    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
