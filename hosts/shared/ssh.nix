{
  config,
  pkgs,
  lib,
  ...
}: {
  services.openssh = {
    enable = true;
    permitRootLogin = lib.mkForce "no";
    openFirewall = true;
    forwardX11 = false;
    useDns = false;
    ports = [22];
    passwordAuthentication = lib.mkForce false;
    kbdInteractiveAuthentication = false;

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
