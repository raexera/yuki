{
  security = {
    # Unlock GPG keyring on login
    pam.services = {
      login = {
        enableGnomeKeyring = true;
      };
    };

    # Don't ask for password for wheel group
    sudo.wheelNeedsPassword = false;

    # Enable Trusted Platform Module 2 support
    tpm2.enable = true;
  };
}
