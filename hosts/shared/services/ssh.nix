{
  lib,
  pkgs,
  ...
}: {
  services.openssh = {
    enable = true;
    openFirewall = true;
    forwardX11 = false;
    ports = [22];

    settings = {
      useDns = false;
      kbdInteractiveAuthentication = false;
      passwordAuthentication = lib.mkForce false;
      permitRootLogin = lib.mkForce "no";
    };

    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  programs.ssh.startAgent = true;
}
