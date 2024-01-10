{lib, ...}: {
  imports = [
    ./ssh.nix
  ];

  networking = {
    extraHosts = builtins.readFile (
      builtins.fetchurl {
        url = "https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts";
        sha256 = "0993ms2lk7n3h82ccj2iabkaf9bzalrkmw9dg70jsfa7cc8309km";
      }
    );

    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
