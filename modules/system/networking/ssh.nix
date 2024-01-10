{lib, ...}: {
  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = lib.mkForce "yes";
      PasswordAuthentication = lib.mkForce false;
    };
  };
}
