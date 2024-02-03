{
  programs = {
    ssh.startAgent = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "yes";
      X11Forwarding = false;
    };
  };
}
